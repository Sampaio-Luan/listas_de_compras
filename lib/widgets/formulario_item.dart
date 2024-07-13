import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../mixins/validations_mixin.dart';
import '../models/item.module.dart';
import '../theme/estilos.dart';

import 'campos_formulario.dart';

class FormularioItem extends StatefulWidget {
  final ItemModel? item;
  final int? idLista;

  const FormularioItem({super.key, this.item, this.idLista});

  @override
  State<FormularioItem> createState() => _FormularioItemState();
}

class _FormularioItemState extends State<FormularioItem> with ValidacoesMixin {
  TextEditingController nomeItem = TextEditingController();
  TextEditingController descricaoItem = TextEditingController();
  TextEditingController quantidadeItem = TextEditingController();
  TextEditingController precoItem = TextEditingController();
  TextEditingController tipoMedida = TextEditingController();
  final formKeyItem = GlobalKey<FormState>();

  CamposFormulario cf = CamposFormulario();
  bool autoValidar = false;

  String resumo = '';
  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
      String p = formatter.format(widget.item!.preco);
      nomeItem.text = widget.item!.nome;
      descricaoItem.text = widget.item!.descricao;
      quantidadeItem.text = widget.item!.quantidade.toStringAsFixed(0);
      precoItem.text = p;
      tipoMedida.text = widget.item!.medida;
    } else {
      tipoMedida.text = 'uni';
      quantidadeItem.text = '1';
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemC = context.read<ItensController>();
    return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        title: Text(
          widget.item == null ? 'Cadastrar Item' : 'Editar Item',
          style: Estilos().tituloColor(context, tamanho: 'g'),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: formKeyItem,
              autovalidateMode: autoValidar
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                cf.linha(
                  context,
                  controle: nomeItem,
                  label: 'Item',
                  qtdLinha: 1,
                  valida: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    tipoMedida.text == 'uni'
                        ? Expanded(
                            flex: 2,
                            child: cf.apenasNumeros(
                              context,
                              controle: quantidadeItem,
                              label: 'Quantidade',
                              qtdLinha: 1,
                              valida: true,
                            ),
                          )
                        : Expanded(
                            flex: 2,
                            child: cf.decimal(
                              context,
                              controle: quantidadeItem,
                              label: 'Quantidade',
                              valida: true,
                              tipoM: tipoMedida,
                            ),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          style: Estilos().corpoColor(context, tamanho: 'p'),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          value: tipoMedida.text,
                          items: const [
                            DropdownMenuItem(
                              value: 'uni',
                              child: Text('Uni'),
                            ),
                            DropdownMenuItem(
                              value: 'kg',
                              child: Text('Kg'),
                            ),
                          ],
                          onChanged: (value) {
                            tipoMedida.text = value.toString();
                            if (tipoMedida.text == 'uni') {
                              quantidadeItem.text = '1';
                            } else {
                              quantidadeItem.text = '0,${quantidadeItem.text}';
                            }
                            setState(() {});
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  Expanded(
                    flex: 2,
                    child: cf.moeda(
                      context,
                      controle: precoItem,
                      label: 'Preço',
                      valida: true,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      tipoMedida.text == 'uni' ? 'A Unidade' : 'Por Quilo',
                      style: Estilos().tituloColor(context, tamanho: 'p'),
                    ),
                  )
                ]),
                const SizedBox(
                  height: 10,
                ),
                cf.linha(
                  context,
                  controle: descricaoItem,
                  label: 'Descrição',
                  qtdLinha: 2,
                  valida: false,
                ),
                const SizedBox(
                  height: 10,
                ),
              ]),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            child: Text(
              'Cancelar',
              style: Estilos().corpoColor(context, tamanho: 'm'),
            ),
            onPressed: () {
              _resetTextController();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text(
                widget.item == null ? 'Cadastrar' : 'Salvar',
                style: Estilos().corpoColor(context, tamanho: 'm'),
              ),
              onPressed: () {
                setState(() {
                  autoValidar = true;
                });
                if (isValidado(
                        context: context,
                        formularioKey: formKeyItem,
                        mensagem: widget.item == null
                            ? 'Cadastrado com sucesso !!!'
                            : 'Editado com sucesso !!!') ==
                    0) {
                  if (widget.item == null) {
                    ItemModel i = ItemModel(
                      idItem: 0,
                      idLista: widget.idLista!,
                      nome: nomeItem.text,
                      descricao:
                          descricaoItem.text.isEmpty ? '' : descricaoItem.text,
                      quantidade: _formatarQuantidade(),
                      medida: tipoMedida.text,
                      preco: _formatarPreco(),
                      comprado: 0,
                      indice: 0,
                    );
                    itemC.adicionarItem(i);
                  } else {
                    widget.item!.nome = nomeItem.text;
                    widget.item!.quantidade = _formatarQuantidade();
                    widget.item!.preco = _formatarPreco();
                    widget.item!.descricao = descricaoItem.text;
                    itemC.atualizarItem(widget.item!);
                  }
                  _resetTextController();
                  Navigator.of(context).pop();
                }
              }),
        ]);
  }

  _resetTextController() {
    nomeItem.clear();
    quantidadeItem.clear();
    precoItem.clear();
    descricaoItem.clear();
  }

  // _formatarValores() {
  //   _formatarQuantidade();
  //   _formatarPreco();

  //   if (tipoMedida.text == 'kg') {
  //     double qtd = _formatarQuantidade();
  //     resumo =
  //         '$qtd ${qtd > 1 ? 'kg' : 'gramas'} de ${nomeItem.text} a ${precoItem.text} reais o quilo.';
  //   } else {
  //     resumo =
  //         '${quantidadeItem.text} ${int.parse(quantidadeItem.text) > 1 ? 'unidades' : 'unidade'} de ${nomeItem.text} a ${precoItem.text} reais ${int.parse(quantidadeItem.text) > 1 ? 'cada' : ''}';
  //   }

  //   setState(() {});
  // }

  _formatarQuantidade() {
    String qtd = quantidadeItem.text;
    qtd = qtd.replaceAll(',', '.');
    debugPrint('Fqtd: $qtd');
    return double.parse(qtd);
  }

  _formatarPreco() {
    String preco = precoItem.text;
    preco = preco.replaceAll(RegExp(r'[^\d,]'), '').replaceAll(',', '.');
    debugPrint('Fpreco: $preco');
    return double.parse(preco);
  }
}
