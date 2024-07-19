import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../controllers/itens_controller.dart';
import '../../controllers/listas_controller.dart';
import '../../mixins/validations_mixin.dart';
import '../../models/item.module.dart';
import '../../theme/estilos.dart';

import 'campos_formulario.dart';

class FormItemModal extends StatefulWidget {
  final ItemModel? item;

  const FormItemModal({super.key, this.item});

  @override
  State<FormItemModal> createState() => _FormItemModalState();
}

class _FormItemModalState extends State<FormItemModal> with ValidacoesMixin {
  TextEditingController nomeItem = TextEditingController();
  TextEditingController descricaoItem = TextEditingController();
  TextEditingController quantidadeItem = TextEditingController();
  TextEditingController precoItem = TextEditingController();
  TextEditingController tipoMedida = TextEditingController();
  TextEditingController prioridadeItem = TextEditingController();
  final formKeyItem = GlobalKey<FormState>();

  List<String> prioridades = ['0', 'Alta', 'Média', 'Baixa', 'Nula'];
  List<Color> prioridadesColor = [
    Colors.red,
    Colors.red.shade400,
    Colors.orange.shade400,
    Colors.green.shade700,
    Colors.indigo.shade600
  ];

  CamposFormulario cf = CamposFormulario();
  bool autoValidar = true;
  bool mostrarFormCompleto = false;

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

      String precoFormatado = formatter.format(widget.item!.preco);
      nomeItem.text = widget.item!.nome;
      descricaoItem.text = widget.item!.descricao;
      quantidadeItem.text = widget.item!.medida == 'uni'
          ? widget.item!.quantidade.toStringAsFixed(0)
          : widget.item!.quantidade.toStringAsFixed(3);
      precoItem.text = precoFormatado;
      tipoMedida.text = widget.item!.medida;
      prioridadeItem.text = '4';
    } else {
      tipoMedida.text = 'uni';
      quantidadeItem.text = '1';
      prioridadeItem.text = '4';
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemC = context.watch<ItensController>();
    return BottomSheet(
        backgroundColor: Theme.of(context).colorScheme.background,
        enableDrag: false,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 1,
        onClosing: () {},
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
           
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Form(
                  key: formKeyItem,
                  autovalidateMode: autoValidar
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: [
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  setState(() {
                                    debugPrint(
                                        'Mostra tudo $mostrarFormCompleto');
                                    mostrarFormCompleto = !mostrarFormCompleto;
                                  });
                                },
                                icon: Icon(
                                  mostrarFormCompleto
                                      ? PhosphorIconsRegular.caretUp
                                      : PhosphorIconsRegular.caretDown,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              flex: 17,
                              child: Stack(
                                  alignment: Alignment.centerRight,
                                  clipBehavior: Clip.hardEdge,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: cf.linha(
                                        context,
                                        controle: nomeItem,
                                        label: 'Item',
                                        qtdLinha: 1,
                                        valida: true,
                                      ),
                                    ),
                                    Positioned(
                                      child: IconButton.filled(
                                        onPressed: () {},
                                        icon: const Icon(
                                          PhosphorIconsDuotone.paperPlane,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ]),
                          mostrarFormCompleto
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(children: [
                                      tipoMedida.text == 'uni'
                                          ? Expanded(
                                              flex: 3,
                                              child: cf.apenasNumeros(
                                                context,
                                                controle: quantidadeItem,
                                                label: 'Quantidade',
                                                qtdLinha: 1,
                                                valida: true,
                                              ),
                                            )
                                          : Expanded(
                                              flex: 3,
                                              child: cf.decimal(
                                                context,
                                                controle: quantidadeItem,
                                                label: 'Quantidade',
                                                valida: true,
                                                tipoM: tipoMedida,
                                              ),
                                            ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 3,
                                        child: cf.moeda(
                                          context,
                                          controle: precoItem,
                                          label: 'Preço',
                                          valida: true,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          flex: 2,
                                          child: _tipoDeMedida(context)),
                                    ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(children: [
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 3.0),
                                            child: _prioridade(context)),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 5,
                                        child: MultiSelectDropDown(
                                          fieldBackgroundColor:
                                              Colors.transparent,
                                          inputDecoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.transparent,
                                          ),
                                          showChipInSingleSelectMode: true,
                                          dropdownMargin: 0,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          clearIcon: null,
                                          //controller: _controller,
                                          //searchEnabled: true,
                                          onOptionSelected: (options) {
                                            debugPrint(options.toString());
                                          },
                                          options: const <ValueItem>[
                                            ValueItem(
                                                label: 'Option 1', value: '1'),
                                            ValueItem(
                                                label: 'Option 2', value: '2'),
                                            ValueItem(
                                                label: 'Option 3', value: '3'),
                                            ValueItem(
                                                label: 'Option 4', value: '4'),
                                            ValueItem(
                                                label: 'Option 5', value: '5'),
                                            ValueItem(
                                                label: 'Option 6', value: '6'),
                                          ],

                                          selectionType: SelectionType.single,

                                          dropdownHeight: 150,
                                          optionTextStyle:
                                              const TextStyle(fontSize: 14),
                                          selectedOptionIcon:
                                              const Icon(Icons.check_circle),
                                        ),
                                      ),
                                    ]),
                                    const SizedBox(height: 5),
                                    Row(children: [
                                      const Expanded(
                                          child: Text('Prioridade:')),
                                      Expanded(
                                        child: Text(
                                          prioridades[int.parse(
                                            prioridadeItem.text,
                                          )],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: prioridadesColor[
                                                int.parse(prioridadeItem.text)],
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    Row(children: [
                                      Expanded(
                                        child: cf.linha(
                                          context,
                                          controle: descricaoItem,
                                          label: 'Descrição',
                                          qtdLinha: 2,
                                          valida: false,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      TextButton(
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
                                                    _formatarQuantidade(),
                                                medida: tipoMedida.text,
                                                preco: _formatarPreco(),
                                                comprado: 0,
                                                indice: 0,
                                              );
                                              listaC.qtdItensLista(
                                                  itemC.getIdLista,
                                                  itemC.itens.length + 1);
                                              itemC.adicionarItem(i);
                                            } else {
                                              widget.item!.nome = nomeItem.text;
                                              widget.item!.quantidade =
                                                  _formatarQuantidade();
                                              widget.item!.medida =
                                                  tipoMedida.text;
                                              widget.item!.preco =
                                                  _formatarPreco();
                                              widget.item!.descricao =
                                                  descricaoItem.text;
                                              itemC.atualizarItem(widget.item!);
                                            }
                                            _resetTextController();
                                            //Navigator.of(context).pop();
                                            setState(() {
                                              mostrarFormCompleto = false;
                                            });
                                          }
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.1)),
                                        ),
                                        child: Text('Salvar',
                                            style: Estilos().corpoColor(context,
                                                tamanho: 'm')),
                                      ),
                                    ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              : const SizedBox(height: 0),
                        ]),
                  ),
                ),
              ),
               SizedBox(height: itemC.itensInterface.isEmpty ? 0 : 10,),
              itemC.itensInterface.isEmpty
                  ? const Text('')
                  : 
              Container(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     
                      const Divider(
                      height: 0,
                    ),
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
                            style: Estilos().tituloColor(context, tamanho: 'p'),
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
            ],
          );
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

  _tipoDeMedida(context) {
    return SegmentedButton<String>(
      showSelectedIcon: false,
      style: SegmentedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
            double quantidade =
                double.parse(quantidadeItem.text.replaceAll(',', '.'));
            quantidadeItem.text = quantidade.toStringAsFixed(0);
          } else {
            quantidadeItem.text = '0,${quantidadeItem.text}';
          }
        });
      },
    );
  }

  _prioridade(context) {
    return SegmentedButton<int>(
      showSelectedIcon: false,
      style: SegmentedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        selectedBackgroundColor: int.tryParse(prioridadeItem.text) == 4
            ? Theme.of(context).colorScheme.primary
            : prioridadesColor[int.parse(prioridadeItem.text)],
        selectedForegroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      segments: const <ButtonSegment<int>>[
        ButtonSegment<int>(
          value: 1,
          label: Text('A'),
        ),
        ButtonSegment<int>(
          value: 2,
          label: Text('M'),
        ),
        ButtonSegment<int>(
          value: 3,
          label: Text('B'),
        ),
        ButtonSegment<int>(
          value: 4,
          label: Text('N'),
        ),
      ],
      selected: <int>{int.parse(prioridadeItem.text)},
      onSelectionChanged: (Set<int> newSelection) {
        setState(() {
          prioridadeItem.text = newSelection.first.toString();
        });
      },
    );
  }
}
