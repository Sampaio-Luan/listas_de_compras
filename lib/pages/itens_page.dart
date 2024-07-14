import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../models/item.module.dart';
import '../models/lista.module.dart';
import '../theme/estilos.dart';
import '../widgets/formulario_item.dart';
import '../widgets/n_layout_item.dart';
import '../widgets/painel_controle.dart';

class ItensPage extends StatefulWidget {
  final ListaModel lista;

  const ItensPage({super.key, required this.lista});

  @override
  State<ItensPage> createState() => _ItensPageState();
}

class _ItensPageState extends State<ItensPage> {
  TextEditingController pesquisarPorItem = TextEditingController();
  void doNothing(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<ItensController>();
    return Scaffold(
      appBar: ctrl.itensSelecionados.isNotEmpty
          ? _appBarSelecionados(context)
          : ctrl.isPesquisar
              ? _appBarPesquisa(context)
              : _appBarPadrao(context),
      body: ctrl.itens.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '📝\nAinda sem itens em " ${widget.lista.nome} " , cadastre algum no botão de adcionar no canto inferior direito',
                  textAlign: TextAlign.center,
                  style: Estilos().corpoColor(context, tamanho: 'g'),
                ),
              ),
            )
          : Column(children: [
              ctrl.isPesquisar && ctrl.itensInterface.isEmpty
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 50),
                      child: Text(
                          'Não há "${pesquisarPorItem.text}" em ${widget.lista.nome}',
                          textAlign: TextAlign.center,
                          style: Estilos().corpoColor(context, tamanho: 'g')),
                    )
                  : const Expanded(child: PainelControle(itemOuLista: 'item')),
              Expanded(
                flex: 15,
                child: Column(children: [
                  Consumer<ItensController>(builder: (context, controle, _) {
                    return controle.itensInterface.isEmpty &&
                            !controle.isPesquisar
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
                                  key: ValueKey(controle
                                      .itensInterface[index].idItem
                                      .toString()),

                                  startActionPane: _actionPane(context,
                                      item: controle.itensInterface[index],
                                      tipoActionPane: 'Deletar'),

                                  endActionPane: _actionPane(context,
                                      item: controle.itensInterface[index],
                                      tipoActionPane: 'Editar'),

                                  child: NLayoutItem(
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

  AppBar _appBarPadrao(context) {
    final controle = Provider.of<ItensController>(context, listen: false);
    return AppBar(
      backgroundColor:
          Theme.of(context).colorScheme.brightness == Brightness.light
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
      actions: [
        IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              controle.setIsPesquisar = !controle.isPesquisar;
            })
      ],
      title: Text(
        widget.lista.nome,
        style: TextStyle(
          color: Theme.of(context).colorScheme.brightness == Brightness.light
              ? Theme.of(context).colorScheme.onPrimary.withAlpha(200)
              : Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.brightness == Brightness.light
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }

  AppBar _appBarPesquisa(context) {
    final controle = Provider.of<ItensController>(context, listen: false);
    return AppBar(
      backgroundColor:
          Theme.of(context).colorScheme.brightness == Brightness.light
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            controle.setIsPesquisar = !controle.isPesquisar;
            //controle.sairPesquisa();
            pesquisarPorItem.clear();
            controle.filtrarItens('');
          }),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: TextField(
          controller: pesquisarPorItem,
          style: TextStyle(
              color:
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? Theme.of(context).colorScheme.onPrimary.withAlpha(200)
                      : Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: 18),
          onChanged: (value) {
            controle.pesquisar(pesquisarPor: pesquisarPorItem.text);
          },
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Pesquisar por item',
            hintStyle: TextStyle(
              color:
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? Theme.of(context).colorScheme.onPrimary.withAlpha(170)
                      : Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer
                          .withAlpha(170),
            ),
            isDense: true,
            border: InputBorder.none,
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.brightness == Brightness.light
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }

  AppBar _appBarSelecionados(context) {
    final ctrl = Provider.of<ItensController>(context, listen: false);
    return AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.brightness == Brightness.light
                  ? Theme.of(context).colorScheme.error: Theme.of(context).colorScheme.onError,
        title: Text(ctrl.itensSelecionados.length > 1
            ? '${ctrl.itensSelecionados.length} Itens selecionados'
            : '${ctrl.itensSelecionados.length} Item selecionado'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              ctrl.limparListaSelecionados();
            }),
        actions: [
          
          IconButton(
              icon: const Icon(PhosphorIconsRegular.trash),
              onPressed: () {
                ctrl.excluirItensSelecionados();
              })
        ]);
  }

  ActionPane _actionPane(
    BuildContext context, {
    required ItemModel item,
    required String tipoActionPane,
  }) {
    final ctrl = Provider.of<ItensController>(context, listen: false);
    return ActionPane(
        motion: const ScrollMotion(),
        dismissible: null,
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              if (tipoActionPane == 'Deletar') {
                ctrl.removerItem(item);
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FormularioItem(item: item, idLista: null);
                    });
              }
            },
            backgroundColor: tipoActionPane == 'Deletar'
                ? Colors.red.shade400
                : Theme.of(context).colorScheme.primary,
            icon: tipoActionPane == 'Deletar'
                ? PhosphorIconsRegular.trashSimple
                : PhosphorIconsRegular.pencilLine,
            label: tipoActionPane,
          ),
        ]);
  }
}
