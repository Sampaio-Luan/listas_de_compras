import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../controllers/listas_controller.dart';
import '../models/item.module.dart';
import '../theme/estilos.dart';
import '../widgets/formulario_item.dart';
import '../widgets/n_layout_item.dart';
import '../widgets/painel_controle.dart';

import 'drawer_lista.dart';

class ItensPage extends StatefulWidget {
  const ItensPage({super.key});

  @override
  State<ItensPage> createState() => _ItensPageState();
}

class _ItensPageState extends State<ItensPage> {
  TextEditingController pesquisarPorItem = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<ItensController>();

    final controleListas = context.watch<ListasController>();
    return Scaffold(
      drawer: const DrawerListas(),
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
                  '📝\nAinda sem itens em " ${ctrl.nomeLista} " , cadastre algum no botão de adcionar no canto inferior direito',
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
                          'Não há "${pesquisarPorItem.text}" em ${ctrl.nomeLista}',
                          textAlign: TextAlign.center,
                          style: Estilos().corpoColor(context, tamanho: 'g')),
                    )
                  : const Expanded(flex:2 ,child: PainelControle(itemOuLista: 'item')),
              Expanded(
                flex: 34,
                child: Column(children: [
                  Consumer<ItensController>(builder: (context, controle, _) {
                    return controle.itensInterface.isEmpty &&
                            !controle.isPesquisar
                        ? const Expanded(
                            child: Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 5,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              itemCount: controle.itensInterface.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(height: 1, thickness: 0.5);
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return Slidable(
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
                flex: 3,
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withAlpha(150),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total: ${ctrl.precoTotal}",
                            style: Estilos().tituloColor(
                              context,
                              tamanho: 'm',
                            ),
                          ),
                          Text(
                            "Preço total da lista: ${ctrl.precoTotalLista}",
                            style: Estilos().sutil(
                              context,
                              tamanho: 12,
                            ),
                          ),
                        ]),
                  ),
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
                  idLista: ctrl.idLista,
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
        controle.nomeLista,
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
        backgroundColor:
            Theme.of(context).colorScheme.brightness == Brightness.light
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.onError,
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
