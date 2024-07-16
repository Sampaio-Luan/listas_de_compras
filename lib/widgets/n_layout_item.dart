import 'package:flutter/material.dart';

import 'package:expandable_text/expandable_text.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../models/item.module.dart';
import '../theme/estilos.dart';

class NLayoutItem extends StatefulWidget {
  final ItemModel item;

  const NLayoutItem({
    super.key,
    required this.item,
  });

  @override
  State<NLayoutItem> createState() => _NLayoutItemState();
}

class _NLayoutItemState extends State<NLayoutItem> {
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

  @override
  Widget build(BuildContext context) {
    return Consumer<ItensController>(builder: (context, itemC, _) {
      return InkWell(
        onLongPress: () {
          itemC.itensSelecionados.isEmpty
              ? itemC.selecionarItens(widget.item)
              : null;
        },
        onTap: () {
          itemC.itensSelecionados.isEmpty
              ? null
              : itemC.selecionarItens(widget.item);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: itemC.itensSelecionados.contains(widget.item)
              ? Theme.of(context).colorScheme.brightness == Brightness.light
                  ? Theme.of(context).colorScheme.errorContainer
                  : Theme.of(context).colorScheme.onError
              : widget.item.comprado == 0
                  ? null
                  : Theme.of(context).colorScheme.brightness == Brightness.light
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withAlpha(70),
          child: Row(children: [
            Expanded(
              child: itemC.itensSelecionados.isNotEmpty &&
                      itemC.itensSelecionados.contains(widget.item)
                  ? CircleAvatar(
                      //radius: 30,
                      backgroundColor:
                          Theme.of(context).colorScheme.brightness ==
                                  Brightness.light
                              ? Theme.of(context).colorScheme.error
                              : Colors.red,
                      child: const Icon(PhosphorIconsRegular.fileX,
                          color: Colors.white, size: 30),
                    )
                  : CircleAvatar(
                      //radius: 25,
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      foregroundColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      child: Text(
                        widget.item.nome.substring(0, 1).toUpperCase(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.item.nome,
                        style: Estilos().tituloColor(context, tamanho: 'p'),
                      ),
                      widget.item.descricao.isEmpty
                          ? const SizedBox()
                          : ExpandableText(
                              textAlign: TextAlign.justify,
                              widget.item.descricao,
                              style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha(190), fontSize: 12),
                              expandText: 'Mostrar +',
                              collapseText: 'Mostrar -',
                              maxLines: 1,
                              //linkColor: Colors.blue,
                            ),
                      Row(children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            '${widget.item.medida == 'uni' ? widget.item.quantidade.toStringAsFixed(0) : widget.item.quantidade.toStringAsFixed(3)} ${widget.item.medida}',
                            style: Estilos().sutil(context, tamanho: 12),
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'X',
                           style: Estilos().sutil(context, tamanho: 9),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            formatter.format(widget.item.preco),
                            style: Estilos().sutil(context, tamanho: 11),
                            //textAlign: TextAlign.end,
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Text(
                            '=',
                            style: Estilos().sutil(context, tamanho: 9),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            formatter.format(
                                widget.item.quantidade * widget.item.preco),
                            style: Estilos().sutil(context, tamanho: 11),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ]),
                    ]),
              ),
            ),
            Expanded(
              child: Checkbox(
                  value: widget.item.comprado == 0 ? false : true,
                  onChanged: (value) {
                    if (value != null) {
                      widget.item.comprado = value ? 1 : 0;
                      itemC.atualizarItem(widget.item);
                    }
                  }),
            ),
          ]),
        ),
      );
    });
  }
}
