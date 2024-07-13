import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import 'package:listas_de_compras/widgets/formulario_item.dart';

import '../controllers/itens_controller.dart';
import '../models/lista.module.dart';
import '../theme/estilos.dart';
import '../widgets/layout_item.dart';
import '../widgets/painel_controle.dart';

class ItensPage extends StatefulWidget {
  final ListaModel lista;

  const ItensPage({super.key, required this.lista});

  @override
  State<ItensPage> createState() => _ItensPageState();
}

class _ItensPageState extends State<ItensPage> {
  TextEditingController pesquisarPorItem = TextEditingController();
  bool pesquisar = false;
  void doNothing(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<ItensController>();
    return Scaffold(
      appBar: pesquisar
          ? _appBarPesquisa(context)
          : _appBar(titulo: widget.lista.nome),
      body: ctrl.itens.isEmpty
          ? const Center(
              child: Text(
                'Nenhum item encontrado',
              ),
            )
          : Column(children: [
              pesquisar
                  ? const SizedBox.shrink()
                  : const Expanded(
                      child: PainelControle(
                        itemOuLista: 'item',
                      ),
                    ),
              Expanded(
                flex: 15,
                child: Column(children: [
                  Consumer<ItensController>(builder: (context, controle, _) {
                    return controle.itensInterface.isEmpty
                        ? Expanded(
                            child: Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 5,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              itemCount: controle.itensInterface.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(
                                  height: 2,
                                );
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return Slidable(
                                  // Specify a key if the Slidable is dismissible.
                                  key: const ValueKey(0),

                                  startActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      dismissible: null,
                                      children: [
                                        SlidableAction(
                                            onPressed: (BuildContext context) {
                                              ctrl.removerItem(
                                                controle.itensInterface[index],
                                              );
                                            },
                                            backgroundColor:
                                                Colors.red.shade400,
                                            icon: PhosphorIconsRegular
                                                .trashSimple,
                                            label: 'Deletar'),
                                      ]),

                                  endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                            flex: 1,
                                            onPressed: (BuildContext context) {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return FormularioItem(
                                                      item: controle
                                                              .itensInterface[
                                                          index],
                                                      idLista: null,
                                                    );
                                                  });
                                            },
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            icon:
                                                PhosphorIconsRegular.pencilLine,
                                            label: 'Editar'),
                                      ]),

                                  child: LayoutItem(
                                      item: controle.itensInterface[index]),
                                );
                              },
                            ),
                          );
                  }),
                ]),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(children: [
                    Text(
                      "Total: ${ctrl.precoTotal}",
                      style: Estilos().tituloColor(
                        context,
                        tamanho: 'g',
                      ),
                    ),
                  ]),
                ),
              ),
            ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return FormularioItem(
                  item: null,
                  idLista: widget.lista.id,
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar _appBar({required String titulo}) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(titulo),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              pesquisar = !pesquisar;
            });
          },
          icon: const Icon(
            PhosphorIconsBold.magnifyingGlass,
          ),
        ),
      ],
    );
  }

  AppBar _appBarPesquisa(context) {
    final ctrl = Provider.of<ItensController>(context, listen: false);
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              pesquisar = !pesquisar;
            });
          }),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: TextField(
          controller: pesquisarPorItem,
          onEditingComplete: () {},
          onChanged: (value) {
            ctrl.pesquisar(pesquisarPor: pesquisarPorItem.text);
          },
          //style: const TextStyle(color: Colors.black),
          //cursorColor: cor[widget.lis.tema],
          autofocus: true,
          decoration: const InputDecoration(
              //focusColor: cor[widget.lis.tema],
              //focusedBorder: UnderlineInputBorder(
              // borderSide: BorderSide(color: Colors.black)),
              //enabledBorder: UnderlineInputBorder(
              //  borderSide: BorderSide(color: Colors.black)),
              ),
        ),
      ),
    );
  }
}
