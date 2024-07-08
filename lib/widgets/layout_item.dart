import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/item.module.dart';
import '../repositories/itens_repository.dart';
import '../theme/estilos.dart';

import 'opcoes_modificacao.dart';

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
    final itemR = context.read<ItensRepository>();
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
                      item.comprado = value ? 1 : 0;
                      itemR.atualizarItem(item);
                    });
                  },
                ),
                OpcoesModificacao(item: item),
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
}
