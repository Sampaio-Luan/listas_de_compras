import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../controllers/itens_controller.dart';
import '../../controllers/listas_controller.dart';
import '../../mixins/validations_mixin.dart';
import '../../models/item.module.dart';
import '../../models/prioridades.module.dart';
import '../../repositories/categorias_repository.dart';
import '../../theme/estilos.dart';

import 'botao_segmentado.dart';
import 'botao_segmentado_medida.dart';
import 'campos_formulario.dart';
import 'categoria_dropmenu.dart';

class FormItemModal extends StatefulWidget {
  const FormItemModal({super.key});

  @override
  State<FormItemModal> createState() => _FormItemModalState();
}

class _FormItemModalState extends State<FormItemModal> with ValidacoesMixin {
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
  TextEditingController nomeItem = TextEditingController();
  TextEditingController descricaoItem = TextEditingController();
  TextEditingController quantidadeItem = TextEditingController();
  TextEditingController precoItem = TextEditingController();
  TextEditingController tipoMedida = TextEditingController();
  TextEditingController prioridadeItem = TextEditingController();
  TextEditingController categoriaItem = TextEditingController();
  final formKeyItem = GlobalKey<FormState>();

  final prioridade = Prioridades();
  CamposFormulario cf = CamposFormulario();
  bool autoValidar = false;
  bool isDropdown = false;

  @override
  void initState() {
    prioridadeItem.text = '3';
    categoriaItem.text = '0';
    tipoMedida.text = 'uni';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemC = context.watch<ItensController>();
    final categoriaR = context.watch<CategoriasRepository>();
    //_resetTextController();

    if (itemC.isFormEdicao) {
      String precoFormatado = formatter.format(itemC.itemParaEdicaoForm!.preco);
      nomeItem.text = itemC.itemParaEdicaoForm!.nome;
      descricaoItem.text = itemC.itemParaEdicaoForm!.descricao;
      quantidadeItem.text = itemC.itemParaEdicaoForm!.medida == 'uni'
          ? itemC.itemParaEdicaoForm!.quantidade.toStringAsFixed(0)
          : itemC.itemParaEdicaoForm!.quantidade.toStringAsFixed(3);
      precoItem.text = precoFormatado;
      tipoMedida.text = itemC.itemParaEdicaoForm!.medida;
      prioridadeItem.text = itemC.itemParaEdicaoForm!.prioridade.toString();
      categoriaItem.text = itemC.itemParaEdicaoForm!.idCategoria.toString();
    }
    return BottomSheet(
        backgroundColor: itemC.isFormEdicao
            ? Theme.of(context).colorScheme.primaryContainer.withAlpha(70)
            : Theme.of(context).colorScheme.primaryContainer.withAlpha(5),
        enableDrag: false,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 0,
        onClosing: () {},
        builder: (context) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            itemC.isFormEdicao
                ? const Text('Modo de edição',
                    style: TextStyle(color: Colors.green, fontSize: 20))
                : const SizedBox(height: 0),
            Form(
              key: formKeyItem,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10),
                        child: Row(children: [
                          Expanded(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                itemC.setIsFormCompleto(!itemC.isFormCompleto);
                                itemC.setIsDropDown();
                                if (itemC.isFormEdicao) {
                                  itemC.setIsFormEdicao(false);
                                  nomeItem.clear();
                                  descricaoItem.clear();
                                  quantidadeItem.clear();
                                  precoItem.clear();
                                }
                              },
                              icon: Icon(
                                itemC.isFormEdicao
                                    ? PhosphorIconsRegular.xCircle
                                    : itemC.isFormCompleto
                                        ? PhosphorIconsRegular.caretDown
                                        : PhosphorIconsRegular.caretUp,
                                color: Theme.of(context).colorScheme.primary,
                                size: itemC.isFormEdicao ? 30 : 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 17,
                            child: Stack(
                                alignment: Alignment.centerRight,
                                clipBehavior: Clip.hardEdge,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: cf.linha(
                                      context,
                                      controle: nomeItem,
                                      label: 'Item',
                                      qtdLinha: 1,
                                      valida: false,
                                    ),
                                  ),
                                  Positioned(
                                    child: IconButton.filled(
                                      style: ButtonStyle(
                                        backgroundColor: itemC.isFormEdicao
                                            ? MaterialStateProperty.all(
                                                Colors.green)
                                            : MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                      ),
                                      onPressed: () {
                                        debugPrint(
                                            'Prioridade no modal ${prioridadeItem.text}');
                                        if (nomeItem.text.isNotEmpty) {
                                          if (itemC.isFormEdicao) {
                                            ItemModel itemEditado =
                                                itemC.itemParaEdicaoForm!;
                                            itemEditado.nome = nomeItem.text;
                                            itemEditado.descricao =
                                                descricaoItem.text.isEmpty
                                                    ? ''
                                                    : descricaoItem.text;
                                            itemEditado.quantidade =
                                                quantidadeItem.text.isEmpty
                                                    ? 1
                                                    : _formatarQuantidade();
                                            itemEditado.medida =
                                                tipoMedida.text;
                                            itemEditado.preco =
                                                precoItem.text.isEmpty
                                                    ? 0
                                                    : _formatarPreco();
                                            itemEditado.prioridade =
                                                int.parse(prioridadeItem.text);

                                            itemC.atualizarItem(itemEditado);
                                            itemC.setIsDropDown();
                                          } else {
                                            final listaC = context
                                                .read<ListasController>();
                                            ItemModel i = ItemModel(
                                              idItem: 0,
                                              idLista: itemC.getIdLista,
                                              nome: nomeItem.text,
                                              descricao:
                                                  descricaoItem.text.isEmpty
                                                      ? ''
                                                      : descricaoItem.text,
                                              quantidade:
                                                  quantidadeItem.text.isEmpty
                                                      ? 1
                                                      : _formatarQuantidade(),
                                              medida: tipoMedida.text,
                                              preco: precoItem.text.isEmpty
                                                  ? 0
                                                  : _formatarPreco(),
                                              comprado: 0,
                                              indice: 0,
                                              prioridade: int.parse(
                                                  prioridadeItem.text),
                                              idCategoria:
                                                  int.parse(categoriaItem.text),
                                            );
                                            listaC.qtdItensLista(
                                                itemC.getIdLista,
                                                itemC.itens.length + 1);
                                            itemC.adicionarItem(i, listaC);
                                          }
                                          isValidado(
                                              context: context,
                                              formularioKey: formKeyItem,
                                              mensagem: itemC.isFormEdicao
                                                  ? 'Editado com sucesso !!!'
                                                  : 'Cadastrado com sucesso !!!');
                                          _resetTextController();

                                          itemC.setIsFormEdicao(false);
                                          itemC.setIsDropDown();
                                        }
                                      },
                                      icon: Icon(
                                        itemC.isFormEdicao
                                            ? PhosphorIconsBold.check
                                            : PhosphorIconsDuotone.paperPlane,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                      ),
                      itemC.isFormCompleto
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(children: [
                                Row(children: [
                                  Expanded(
                                    flex: 5,
                                    child: itemC.isDropDown
                                        ? Row(
                                            children: [
                                              const Text('Categoria:'),
                                              const SizedBox(width: 10),
                                              InputChip(
                                                avatar: Icon(
                                                  Icons.close,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                ),
                                                labelStyle: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary),
                                                showCheckmark: false,
                                                selectedColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                selected: true,
                                                onSelected: (value) {
                                                  itemC.setIsDropDown();
                                                },
                                                label: Text(
                                                  categoriaR.getCategorias
                                                      .firstWhere((element) =>
                                                          element.id ==
                                                          itemC
                                                              .itemParaEdicaoForm!
                                                              .idCategoria)
                                                      .nome, overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )
                                        : CategoriaDropMenu(
                                            controle: categoriaItem,
                                            isItemPadrao: false,
                                          ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: BotaoSegmentado(
                                        prioridadeForm: prioridadeItem,
                                      ),
                                    ),
                                  ),
                                ]),
                                Row(children: [
                                  tipoMedida.text == 'uni'
                                      ? Expanded(
                                          flex: 3,
                                          child: cf.apenasNumeros(
                                            context,
                                            controle: quantidadeItem,
                                            label: 'Quantidade',
                                            qtdLinha: 1,
                                            valida: false,
                                          ),
                                        )
                                      : Expanded(
                                          flex: 3,
                                          child: cf.decimal(
                                            context,
                                            controle: quantidadeItem,
                                            label: 'Quantidade',
                                            valida: false,
                                            tipoM: tipoMedida,
                                          ),
                                        ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    flex: 2,
                                    child: BotaoSegmentadoMedidada(
                                      medida: tipoMedida,
                                      valor: quantidadeItem,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    flex: 3,
                                    child: cf.moeda(
                                      context,
                                      controle: precoItem,
                                      label: 'Preço',
                                      valida: false,
                                    ),
                                  ),
                                ]),
                                const SizedBox(height: 10),
                                cf.linha(
                                  context,
                                  controle: descricaoItem,
                                  label: 'Descrição',
                                  qtdLinha: 2,
                                  valida: false,
                                ),
                              ]),
                            )
                          : const SizedBox(height: 0),
                    ]),
              ),
            ),
            SizedBox(height: itemC.itensInterface.isEmpty ? 0 : 10),
            itemC.itensInterface.isEmpty
                ? const Text('')
                : Container(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Divider(height: 0),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(children: [
                              Icon(
                                PhosphorIconsBold.checkSquare,
                                size: 22,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                itemC.precoTotal,
                                style: Estilos()
                                    .tituloColor(context, tamanho: 'p'),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              "Total da lista: ${itemC.precoTotalLista}",
                              style: Estilos().sutil(context, tamanho: 12),
                            ),
                          ),
                          const SizedBox(height: 5),
                        ]),
                  ),
          ]);
        });
  }

  _resetTextController() {
    nomeItem.clear();
    quantidadeItem.clear();
    precoItem.clear();
    descricaoItem.clear();
  }

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

  // _tipoDeMedida(context) {
  //   return SegmentedButton<String>(
  //     showSelectedIcon: false,
  //     style: SegmentedButton.styleFrom(
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         selectedBackgroundColor: Theme.of(context).colorScheme.primary,
  //         selectedForegroundColor: Theme.of(context).colorScheme.onPrimary,
  //         padding: const EdgeInsets.all(0)),
  //     segments: const <ButtonSegment<String>>[
  //       ButtonSegment<String>(
  //         value: 'uni',
  //         label: Text('Uni'),
  //       ),
  //       ButtonSegment<String>(
  //         value: 'kg',
  //         label: Text('Kg'),
  //       ),
  //     ],
  //     selected: <String>{tipoMedida.text.isEmpty ? 'uni' : tipoMedida.text},
  //     onSelectionChanged: (Set<String> newSelection) {
  //       setState(() {
  //         tipoMedida.text = newSelection.first;

  //         if (tipoMedida.text == 'uni') {
  //           double quantidade = quantidadeItem.text.isEmpty
  //               ? 1
  //               : double.parse(quantidadeItem.text.replaceAll(',', '.'));
  //           quantidadeItem.text = quantidade.toStringAsFixed(0);
  //         } else {
  //           quantidadeItem.text = '0,${quantidadeItem.text}';
  //         }
  //       });
  //     },
  //   );
  // }
}
