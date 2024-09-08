import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../constants/const_strings_globais.dart';
import '../controllers/itens_controller.dart';
import '../controllers/listas_controller.dart';
import '../models/item.module.dart';
import '../preferencias_usuario.dart';
import '../repositories/categorias_repository.dart';
import '../theme/estilos.dart';
import '../widgets/formularios/form_item_modal.dart';
import '../widgets/formularios/formulario_item.dart';
import '../widgets/item_layout.dart';
import '../widgets/opcoes_finalizacao.dart';
import '../widgets/painel_controle.dart';

import 'drawer_lista.dart';
import 'end_drawer_itens_padrao.dart';

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
    final ctrlListas = context.watch<ListasController>();
    final preferencias = context.watch<PreferenciasUsuarioShared>();

    return Scaffold(
      drawer: const DrawerListas(),
      endDrawer: EndDrawerItensPadrao(),
      //#region ====================================== APP BAR ========================================================
      appBar: ctrlListas.listas.isEmpty
          ? AppBar(
              title: const Text('Não há listas'),
              centerTitle: true,
              backgroundColor:
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primaryContainer,
              foregroundColor:
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onPrimaryContainer,
            )
          : ctrl.itensSelecionados.isNotEmpty
              ? _appBarSelecionados(context)
              : ctrl.isPesquisar
                  ? _appBarPesquisa(context)
                  : _appBarPadrao(context),
      //#endregion ====================================================================================================

      //#region ====================================== BODY CASO SEM ITENS ============================================
      body: ctrlListas.listas.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIconsRegular.listChecks,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary.withAlpha(200),
                ),
                const SizedBox(height: 20),
                Text(
                  'Adicione uma lista, usando o menu lateral esquerdo.',
                  style: Estilos().corpoColor(context, tamanho: 'g'),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : ctrl.itens.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      '📝\nAinda sem itens em " ${ctrl.nomeLista} " , cadastre algum digitando o nome do item e apertando em enviar, ou use o menu de itens padrão para adicionar itens de forma rápida.',
                      textAlign: TextAlign.center,
                      style: Estilos().corpoColor(context, tamanho: 'g'),
                    ),
                  ),
                )
              //#endregion =======================================================================================================

              //#region ====================================== BODY CASO COM ITENS ============================================
              : Column(children: [
                  //#region ====================================== PAINEL CONTROLE ================================================
                  const Expanded(
                    flex: 2,
                    child: PainelControle(itemOuLista: 'item'),
                  ),
                  //#endregion ====================================================================================================

                  //#region ====================================== MENSSAGEM CASO SEM ITENS EM PESQUISA OU FILTRO =================
                  ctrl.isPesquisar && ctrl.itensInterface.isEmpty ||
                          ctrl.filtro.isNotEmpty && ctrl.itensInterface.isEmpty
                      ? Expanded(
                          flex: 34,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, top: 50),
                            child: Text(
                              ctrl.filtro.isNotEmpty
                                  ? "Não há itens ${ctrl.filtro}"
                                  : 'Não há "${pesquisarPorItem.text}" em ${ctrl.nomeLista}',
                              textAlign: TextAlign.center,
                              style:
                                  Estilos().corpoColor(context, tamanho: 'g'),
                            ),
                          ),
                        )
                      //#endregion =======================================================================================================

                      //#region ====================================== LISTA DE ITENS =================================================
                      : Expanded(
                          flex: 34,
                          child: Column(children: [
                            Consumer<ItensController>(
                                builder: (context, controle, _) {
                              return controle.itensInterface.isEmpty &&
                                      !controle.isPesquisar &&
                                      controle.filtro.isEmpty
                                  ? const Expanded(
                                      child: Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator
                                              .adaptive(strokeWidth: 5),
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: controle.isFormCompleto
                                                ? 340
                                                : 135.0),
                                        child: preferencias.verPorCategoria
                                            ? _createGroupedListView(context)
                                            :
                                            // ListView.builder(
                                            //     itemCount: controle
                                            //         .itemPorCategoria.length,
                                            //     itemBuilder: (context, i) {
                                            //       return Column(children: [
                                            //         Container(
                                            //           height: 90,
                                            //           color: Theme.of(context)
                                            //               .colorScheme
                                            //               .primary
                                            //               .withAlpha(150),
                                            //           child: Text(
                                            //               '${controle.itemPorCategoria.keys.toList()[i]} '),
                                            //         ),
                                            //         Expanded(
                                            //           child: ListView.separated(
                                            //             itemCount: controle.itemPorCategoria.values.toList()[i]
                                            //                 .length,
                                            //             itemBuilder:
                                            //                 (context, index) {
                                            //               return
                                            //               Slidable(
                                            //                 key: ValueKey(controle.itemPorCategoria.values.toList()[i][index]
                                            //                     .idItem
                                            //                     .toString()),
                                            //                 startActionPane:
                                            //                     _actionPane(
                                            //                   context,
                                            //                   item: controle.itemPorCategoria.values.toList()[i][index],
                                            //                   tipoActionPane:
                                            //                       'Deletar',
                                            //                 ),
                                            //                 endActionPane:
                                            //                     _actionPane(
                                            //                   context,
                                            //                   item: controle.itemPorCategoria.values.toList()[i][index],
                                            //                   tipoActionPane:
                                            //                       'Editar',
                                            //                 ),
                                            //                 child: NLayoutItem(
                                            //                     item: controle.itemPorCategoria.values.toList()[i][index]),
                                            //               );
                                            //             },
                                            //             separatorBuilder:
                                            //                 (context, index) {
                                            //               return const Divider(
                                            //                 height: 0,
                                            //                 thickness: 0.7,
                                            //               );
                                            //             },
                                            //           ),
                                            //         )
                                            //       ]);
                                            //     }),

                                            ListView.separated(
                                                itemCount: controle
                                                    .itensInterface.length,
                                                separatorBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return const Divider(
                                                    height: 0,
                                                    thickness: 0.7,
                                                  );
                                                },
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Slidable(
                                                    key: ValueKey(controle
                                                        .itensInterface[index]
                                                        .idItem
                                                        .toString()),
                                                    startActionPane:
                                                        _actionPane(
                                                      context,
                                                      item: controle
                                                              .itensInterface[
                                                          index],
                                                      tipoActionPane: 'Deletar',
                                                    ),
                                                    endActionPane: _actionPane(
                                                      context,
                                                      item: controle
                                                              .itensInterface[
                                                          index],
                                                      tipoActionPane: 'Editar',
                                                    ),
                                                    child: NLayoutItem(
                                                        item: controle
                                                                .itensInterface[
                                                            index]),
                                                  );
                                                },
                                              ),
                                      ),
                                    );
                            }),
                          ]),
                        ),

                  //#endregion ====================================================================================================
                ]),

      //#endregion ====================================================================================================

      //#region ====================================== PAINEL DE PRECO TOTAL ==========================================
      bottomSheet: ctrlListas.listas.isEmpty ? null : const FormItemModal(),
    );
  }

  AppBar _appBarPadrao(context) {
    final controle = Provider.of<ItensController>(context, listen: true);
    return AppBar(
      backgroundColor:
          Theme.of(context).colorScheme.brightness == Brightness.light
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
      foregroundColor:
          Theme.of(context).colorScheme.brightness == Brightness.light
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onPrimaryContainer,
      actions: [
        IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              controle.setIsPesquisar = !controle.isPesquisar;
            }),
        OpcoesFinalizacao(),
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(PhosphorIconsRegular.basket),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ),
      ],
      title: Text(
        controle.nomeLista,
        style: const TextStyle(
          color: Colors.white,
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
    final controle = Provider.of<ItensController>(context, listen: true);
    return AppBar(
      backgroundColor:
          Theme.of(context).colorScheme.brightness == Brightness.light
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
      foregroundColor:
          Theme.of(context).colorScheme.brightness == Brightness.light
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onPrimaryContainer,
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            controle.setIsPesquisar = !controle.isPesquisar;

            pesquisarPorItem.clear();
            controle.filtrarItens(tipoFiltro: '', valor: 0);
          }),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: TextField(
          controller: pesquisarPorItem,
          style: TextStyle(
            color: Theme.of(context).colorScheme.brightness == Brightness.light
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: 18,
          ),
          onChanged: (value) {
            controle.pesquisar(
              pesquisarPor: pesquisarPorItem.text,
            );
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
    final ctrl = Provider.of<ItensController>(context, listen: true);
    final lista = Provider.of<ListasController>(context, listen: true);
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
                ctrl.excluirItensSelecionados(lista);
              })
        ]);
  }

  ActionPane _actionPane(
    BuildContext context, {
    required ItemModel item,
    required String tipoActionPane,
  }) {
    final ctrl = Provider.of<ItensController>(context, listen: false);
    final lista = Provider.of<ListasController>(context, listen: false);
    return ActionPane(
        motion: const ScrollMotion(),
        dismissible: null,
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              if (tipoActionPane == 'Deletar') {
                ctrl.removerItem(item, lista);
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

  _createGroupedListView(context) {
    final ctrl = Provider.of<ItensController>(context, listen: true);
    final categoriaR = Provider.of<CategoriasRepository>(context, listen: true);
    return GroupedListView<ItemModel, int>(
      elements: ctrl.itensInterface,
      groupBy: (element) => element.idCategoria,
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: ctrl.ordem == kPrioridade
          ? (item1, item2) => item1.prioridade.compareTo(item2.prioridade)
          : ctrl.ordem == kCaro
              ? (item1, item2) => item2.preco.compareTo(item1.preco)
              : ctrl.ordem == kBarato
                  ? (item1, item2) => item1.preco.compareTo(item2.preco)
                  : ctrl.ordem == kPadrao || ctrl.ordem.isEmpty
                      ? null
                      : ctrl.ordem == kAz
                          ? (item1, item2) => item1.nome.compareTo(item2.nome)
                          : ctrl.ordem == kZa
                              ? (item1, item2) =>
                                  item2.nome.compareTo(item1.nome)
                              : null,
      order: GroupedListOrder.ASC,
      separator: const Divider(
        height: 0,
        thickness: 0.7,
      ),
      useStickyGroupSeparators: true,
      groupSeparatorBuilder: (dynamic value) => Container(
        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(170),
        child: Text(
          categoriaR.getCategorias
              .where((element) => true)
              .firstWhere((element) => element.id == value as int)
              .nome,
          textAlign: TextAlign.center,
          style: Estilos().tituloColor(context, tamanho: 'm'),
        ),
      ),
      itemBuilder: (c, element) {
        return Slidable(
          key: ValueKey(element.idItem.toString()),
          startActionPane: _actionPane(
            context,
            item: element,
            tipoActionPane: 'Deletar',
          ),
          endActionPane: _actionPane(
            context,
            item: element,
            tipoActionPane: 'Editar',
          ),
          child: NLayoutItem(item: element),
        );
      },
    );
  }
}
