import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../controllers/itens_controller.dart';
import '../../controllers/listas_controller.dart';
import '../../mixins/validations_mixin.dart';
import '../../models/item.module.dart';
import '../../models/item_padrao.module.dart';
import '../../models/prioridades.module.dart';
import '../../repositories/categorias_repository.dart';
import '../../repositories/itens_padrao_repository.dart';
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
    categoriaItem.text = '9';
    tipoMedida.text = 'uni';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemC = context.watch<ItensController>();
    final categoriaR = context.watch<CategoriasRepository>();
    final itemPR = context.watch<ItensPadraoRepository>();
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
    if (itemC.isLimparFormulario) {
      nomeItem.clear();
      descricaoItem.clear();
      quantidadeItem.clear();
      precoItem.clear();
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
            Form(
              key: formKeyItem,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    itemC.isFormEdicao
                        ? Text(
                            'Modo de edição',
                            style: Estilos().tituloColor(context, tamanho: 'm'),
                          )
                        : IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              itemC.setIsFormCompleto(!itemC.isFormCompleto);
                              itemC.setIsDropDown();
                            },
                            icon: Icon(
                              itemC.isFormCompleto
                                  ? PhosphorIconsBold.caretDown
                                  : PhosphorIconsBold.caretUp,
                              color: Theme.of(context).colorScheme.primary,
                              size: 25,
                            ),
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
                                            Expanded(
                                              child: InputChip(
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
                                                      .nome,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
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
                                itemC.isUnidade
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10),
                      child: Row(children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: cf.linha(
                              context,
                              controle: nomeItem,
                              label: 'Item',
                              qtdLinha: 1,
                              valida: false,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Theme.of(context).colorScheme.primary),
                            foregroundColor: WidgetStateProperty.all(
                                Theme.of(context).colorScheme.onPrimary),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 14),
                            ),
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
                                itemEditado.medida = tipoMedida.text;
                                itemEditado.preco = precoItem.text.isEmpty
                                    ? 0
                                    : _formatarPreco();
                                itemEditado.prioridade =
                                    int.parse(prioridadeItem.text);

                                itemEditado.idCategoria =
                                    int.parse(categoriaItem.text);

                                itemC.atualizarItem(itemEditado);
                                itemC.setIsDropDown();
                              } else {
                                final listaC = context.read<ListasController>();
                                ItemModel i = ItemModel(
                                  idItem: 0,
                                  idLista: itemC.getIdLista,
                                  nome: nomeItem.text,
                                  descricao: descricaoItem.text.isEmpty
                                      ? ''
                                      : descricaoItem.text,
                                  quantidade: quantidadeItem.text.isEmpty
                                      ? 1
                                      : _formatarQuantidade(),
                                  medida: tipoMedida.text,
                                  preco: precoItem.text.isEmpty
                                      ? 0
                                      : _formatarPreco(),
                                  comprado: 0,
                                  indice: 0,
                                  prioridade: int.parse(prioridadeItem.text),
                                  idCategoria: int.parse(categoriaItem.text),
                                );

                                ItemPadraoModel ipm = ItemPadraoModel(
                                  idItemPadrao: 0,
                                  idCategoria: i.idCategoria,
                                  nome: i.nome,
                                  categoria: categoriaR.getCategorias
                                      .where((element) => true)
                                      .firstWhere((element) =>
                                          element.id == i.idCategoria)
                                      .nome,
                                );
                                List<String> nomesIP = itemPR.getItensPadrao
                                    .map((element) =>
                                        element.nome.toLowerCase() +
                                        element.idCategoria.toString())
                                    .toList();

                                if (!nomesIP.contains((ipm.nome.toLowerCase() +
                                    ipm.idCategoria.toString()))) {
                                  itemPR.criarItemPadrao(ipm);
                                }

                                listaC.qtdItensLista(
                                    itemC.getIdLista, itemC.itens.length + 1);
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
                          child: const Text(
                            'Salvar',
                          ),
                        ),
                        itemC.isFormEdicao
                            ? Row(
                                children: [
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                          Colors.red.shade400),
                                      foregroundColor: WidgetStateProperty.all(
                                          Colors.white70),
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      padding: WidgetStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 14),
                                      ),
                                    ),
                                    onPressed: () {
                                      itemC.setIsFormCompleto(
                                          !itemC.isFormCompleto);
                                      itemC.setIsDropDown();
                                      itemC.setIsFormEdicao(false);
                                      _resetTextController();
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                ],
                              )
                            : const Text('')
                      ]),
                    ),
                  ]),
            ),
            SizedBox(height: itemC.itensInterface.isEmpty ? 0 : 2),
            itemC.itensInterface.isEmpty
                ? const Text('')
                : Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    child: Row(children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
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
                              style:
                                  Estilos().tituloColor(context, tamanho: 'p'),
                            ),
                          ]),
                        ),
                      ),
                      const VerticalDivider(
                        width: 0.5,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Text(
                            " ${itemC.precoTotalLista}",
                            style: Estilos().sutil(context, tamanho: 14),
                          ),
                        ),
                      ),
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
