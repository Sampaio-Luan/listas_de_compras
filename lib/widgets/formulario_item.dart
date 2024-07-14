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

      String precoFormatado = formatter.format(widget.item!.preco);
      nomeItem.text = widget.item!.nome;
      descricaoItem.text = widget.item!.descricao;
      quantidadeItem.text = widget.item!.medida == 'uni' ? widget.item!.quantidade.toStringAsFixed(0) : widget.item!.quantidade.toStringAsFixed(3);
      precoItem.text = precoFormatado;
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
                    SegmentedButton<String>(
                      showSelectedIcon: false,
                      style: SegmentedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(0),
                        visualDensity:
                            const VisualDensity(vertical: 3, horizontal: -3.5),
                            selectedBackgroundColor: Theme.of(context).colorScheme.primary,
                            selectedForegroundColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                      segments: const <ButtonSegment<String>>[
                        ButtonSegment<String>(
                          value: 'uni',
                          label: Text('Uni'),
                        ),
                        ButtonSegment<String>(
                          value: 'kg',
                          label: Text('Kg'),
                        ),
                      ],
                      selected: <String>{tipoMedida.text},
                      onSelectionChanged: (Set<String> newSelection) {
                        setState(() {
                          tipoMedida.text = newSelection.first;
                          if (tipoMedida.text == 'uni') {
                            double quantidade = double.parse(quantidadeItem.text.replaceAll(',', '.'));
                            quantidadeItem.text = quantidade.toStringAsFixed(0);
                          } else {
                            quantidadeItem.text = '0,${quantidadeItem.text}';
                          }
                        });
                      },
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
                    widget.item!.medida = tipoMedida.text;
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
    debugPrint('Formatar qtd: $qtd');
    return double.parse(qtd);
  }

  _formatarPreco() {
    String preco = precoItem.text;
    preco = preco.replaceAll(RegExp(r'[^\d,]'), '').replaceAll(',', '.');
    debugPrint('Formatar preco: $preco');
    return double.parse(preco);
  }
}

enum Calendar { day, week, month, year }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
            value: Calendar.day,
            label: Text('Day'),
            icon: Icon(Icons.calendar_view_day)),
        ButtonSegment<Calendar>(
            value: Calendar.week,
            label: Text('Week'),
            icon: Icon(Icons.calendar_view_week)),
      ],
      selected: <Calendar>{calendarView},
      onSelectionChanged: (Set<Calendar> newSelection) {
        setState(() {
          calendarView = newSelection.first;
        });
      },
    );
  }
}
