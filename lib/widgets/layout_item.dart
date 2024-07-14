import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../models/item.module.dart';
import '../theme/estilos.dart';

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
    final itemC = context.read<ItensController>();
    return ListTile(
      //isThreeLine: true,
      //contentPadding: const EdgeInsets.only(left: 10.0),
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
      trailing: Checkbox(
        value: item.comprado == 0 ? false : true,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              item.comprado = value ? 1 : 0;
    
              itemC.atualizarItem(item);
            });
          }
        },
      ),
      title: Text(item.nome,
          style: Estilos().tituloColor(context, tamanho: 'p')),
      subtitle:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          item.descricao,
          style: Estilos().sutil(
            context,
            tamanho: 14,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            flex: 3,
            child: Text(
              '${item.medida == 'uni' ? item.quantidade.toStringAsFixed(0) : item.quantidade} ${item.medida}',
            ),
          ),
          const Expanded(child: Text('X')),
          Expanded(
            flex: 4,
            child: Text(
              formatter.format(item.preco),
            ),
          ),
        ]),
      ]),
    );
  }
}
