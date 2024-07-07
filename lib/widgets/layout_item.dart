import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../models/item.module.dart';
import '../repositories/itens_repository.dart';
import '../theme/estilos.dart';

import 'formulario_item.dart';

class LayoutItem extends StatefulWidget {
  final ItemModel item;

  const LayoutItem({super.key, required this.item});

  @override
  State<LayoutItem> createState() => _LayoutItemState();
}

class _LayoutItemState extends State<LayoutItem> {
  late ItemModel item;
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card.filled(
        color: Theme.of(context).colorScheme.brightness == Brightness.light
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.tertiaryContainer,
        elevation: 0,
        child: ListTile(
          isThreeLine: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            child: Text(
              item.nome.substring(0, 1).toUpperCase(),
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.brightness == Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onTertiaryContainer,
                fontSize: 18,
              ),
            ),
          ),
          trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: item.comprado == 0 ? false : true,
                  onChanged: (value) {
                    setState(() {
                      item.comprado = value! == true ? 1 : 0;
                    });
                  },
                ),
                _menu()
              ]),
          title: Text(item.nome,
              style: Estilos().tituloColor(context, tamanho: 'p')),
          subtitle:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(flex: 3, child: Text(item.quantidade.toString())),
            const Expanded(child: Text('X')),
            Expanded(flex: 4, child: Text(formatter.format(item.preco))),
          ]),
        ),
      ),
    );



 }

  _menu() {
    final itensR = context.read<ItensRepository>();
    return PopupMenuButton<dynamic>(
      position: PopupMenuPosition.under,
      elevation: 1,
      itemBuilder: (context) => [
        PopupMenuItem(
          child: _label(label: 'Editar'),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return FormularioItem(
                    item: item,
                    idLista: null,
                  );
                });
          },
        ),
        PopupMenuItem(
          child: _label(label: 'Excluir'),
          onTap: () {
            itensR.excluirItem(item);
          },
        ),
      ],
    );
  }

  _label({required String label}) {
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
