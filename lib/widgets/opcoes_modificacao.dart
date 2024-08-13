import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../controllers/listas_controller.dart';
import '../models/categoria.module.dart';
import '../models/item.module.dart';
import '../models/item_padrao.module.dart';
import '../models/lista.module.dart';
import '../preferencias_usuario.dart';
import '../repositories/categorias_repository.dart';
import '../repositories/itens_padrao_repository.dart';
import '../repositories/itens_repository.dart';
import '../theme/estilos.dart';

import 'formularios/form_categoria.dart';
import 'formularios/form_item_padrao.dart';
import 'formularios/formulario_item.dart';
import 'formularios/formulario_lista.dart';

class OpcoesModificacao extends StatefulWidget {
  final ListaModel? lista;
  final ItemModel? item;
  final CategoriaModel? categoria;
  final ItemPadraoModel? itemPadrao;

  const OpcoesModificacao({
    super.key,
    this.lista,
    this.item,
    this.categoria,
    this.itemPadrao,
  });

  @override
  State<OpcoesModificacao> createState() => _OpcoesModificacaoState();
}

class _OpcoesModificacaoState extends State<OpcoesModificacao> {
  late ListaModel lista;
  late ItemModel item;
  late CategoriaModel categoria;
  late ItemPadraoModel itemPadrao;

  @override
  void initState() {
    if (widget.item != null) {
      item = widget.item!;
    } else if (widget.lista != null) {
      lista = widget.lista!;
    } else if (widget.categoria != null) {
      categoria = widget.categoria!;
    } else {
      itemPadrao = widget.itemPadrao!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listaController = context.watch<ListasController>();
    final itemR = context.watch<ItensRepository>();
    final itensController = context.read<ItensController>();
    final itemPadraoR = context.watch<ItensPadraoRepository>();
    final categoriaR = context.watch<CategoriasRepository>();
    final preferencias = context.watch<PreferenciasUsuarioShared>();
    return PopupMenuButton<dynamic>(
      padding: const EdgeInsets.all(0),
      icon: Icon(
        PhosphorIconsRegular.pencil,
        color: Theme.of(context).colorScheme.primary,
      ),
      position: PopupMenuPosition.under,
      constraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width * 0.3),
      elevation: 1,
      itemBuilder: (context) => [
        PopupMenuItem(
          child: _label(context, label: 'Editar'),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  if (widget.item != null) {
                    return FormularioItem(item: item, idLista: null);
                  } else if (widget.lista != null) {
                    return FormularioLista(lista: lista);
                  } else if (widget.categoria != null) {
                    return FormularioCategoria(categoria: categoria);
                  } else {
                    return FormItemPadrao(itemPadrao: itemPadrao);
                  }
                });
          },
        ),
        PopupMenuItem(
          child: _label(context, label: 'Excluir'),
          onTap: () {
            if (widget.item != null) {
              itemR.excluirItem(item);
            } else if (widget.lista != null) {
              int i = listaController.listas.indexOf(widget.lista!);
              ListaModel l = listaController.listas[i];
              itensController.iniciarController(
                  idLista: l.id, nomeLista: l.nome);
              preferencias.setUltimaListaVisitada(l.id);
              listaController.excluirLista(lista);
            } else if (widget.categoria != null) {
              categoriaR.excluirCategorias(categoria);
            } else {
              itemPadraoR.excluirItemPadrao(itemPadrao);
            }
          },
        ),
      ],
    );
  }

  _label(context, {required String label}) {
    Map<String, Widget> labels = {
      'Editar': Icon(
        PhosphorIconsRegular.clipboardText,
        color: Theme.of(context).colorScheme.primary,
        size: 22,
      ),
      'Excluir': Icon(
        PhosphorIconsRegular.trash,
        color: Theme.of(context).colorScheme.primary,
        size: 22,
      ),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.length <= 6 ? '$label ' : label,
          style: Estilos().corpoColor(context, tamanho: 'p'),
        ),
        const SizedBox(width: 10),
        labels[label]!,
      ],
    );
  }
}
