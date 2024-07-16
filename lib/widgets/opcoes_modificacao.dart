import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/listas_controller.dart';
import '../models/item.module.dart';
import '../models/lista.module.dart';
import '../repositories/itens_repository.dart';
import '../repositories/listas_repository.dart';
import '../theme/estilos.dart';

import 'formulario_item.dart';
import 'formulario_lista.dart';

class OpcoesModificacao extends StatefulWidget {
  final ListaModel? lista;
  final ItemModel? item;

  const OpcoesModificacao({
    super.key,
    this.lista,
    this.item,
  });

  @override
  State<OpcoesModificacao> createState() => _OpcoesModificacaoState();
}

class _OpcoesModificacaoState extends State<OpcoesModificacao> {
  late ListaModel lista;
  late ItemModel item;

  @override
  void initState() {
    if (widget.item != null) {
      item = widget.item!;
    } else {
      lista = widget.lista!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listaController = context.watch<ListasController>();
    final itemR = context.watch<ItensRepository>();
    return PopupMenuButton<dynamic>(
      padding: const EdgeInsets.all(0),
      icon: Icon(
        PhosphorIconsRegular.pencil,

        color: Theme.of(context).colorScheme.primary,
      ),
      position: PopupMenuPosition.under,
      elevation: 1,
      itemBuilder: (context) => [
        PopupMenuItem(
          child: _label(context, label: 'Editar'),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return widget.item == null
                      ? FormularioLista(lista: lista)
                      : FormularioItem(item: item, idLista: null);
                });
          },
        ),
        PopupMenuItem(
          child: _label(context, label: 'Excluir'),
          onTap: () {
            widget.item != null
                ? itemR.excluirItem(item)
                : listaController.excluirLista(lista);
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
