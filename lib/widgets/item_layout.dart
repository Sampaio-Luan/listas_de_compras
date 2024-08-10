import 'package:flutter/material.dart';

import 'package:expandable_text/expandable_text.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../controllers/listas_controller.dart';
import '../models/item.module.dart';
import '../models/prioridades.module.dart';
import '../theme/estilos.dart';

class NLayoutItem extends StatelessWidget {
  final ItemModel item;
  final Prioridades prioridade = Prioridades();

  NLayoutItem({
    super.key,
    required this.item,
  });

  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

  @override
  Widget build(BuildContext context) {
    final lista = context.watch<ListasController>();
    return Consumer<ItensController>(builder: (context, itemC, _) {
      return InkWell(
        onLongPress: () {
          itemC.itensSelecionados.isEmpty ? itemC.selecionarItens(item) : null;
          itemC.setIsFormEdicao(false);
          itemC.setIsFormCompleto(false);
        },
        onTap: () {
          itemC.itensSelecionados.isEmpty ? null : itemC.selecionarItens(item);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: prioridade
                        .corPrioridade(item.prioridade)
                        .withAlpha(130),
                    width: 7),
                right: BorderSide.none,
                bottom: BorderSide.none,
                top: BorderSide.none),
            color: itemC.itensSelecionados.contains(item)
                ? Theme.of(context).colorScheme.brightness == Brightness.light
                    ? Theme.of(context).colorScheme.errorContainer
                    : Theme.of(context).colorScheme.onError
                : item.comprado == 0
                    ? null
                    : Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Colors.black.withAlpha(30)
                        : Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withAlpha(70),
          ),
          padding: const EdgeInsets.only(right: 10),
          child: Row(children: [
            Expanded(
              child: itemC.itensSelecionados.contains(item)
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
                      radius: 15,
                      backgroundColor: prioridade
                          .corPrioridade(item.prioridade)
                          .withAlpha(30),

                      // Theme.of(context)
                      //     .colorScheme
                      //     .inversePrimary
                      //     .withAlpha(100),
                      foregroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      child: Text(
                        item.nome[0].toUpperCase(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
            ),
            Expanded(
              flex: 8,
              child: InkWell(
                onTap: itemC.itensSelecionados.isNotEmpty
                    ? null
                    : () {
                        itemC.habilitarformEdicao(item);
                        itemC.setIsFormEdicao(true);
                        itemC.setIsFormCompleto(true);
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.nome,
                          style: item.comprado == 1
                              ? itemComCheck(context)
                              : Estilos().tituloColor(context, tamanho: 'p'),
                        ),
                        item.descricao.isEmpty
                            ? const SizedBox()
                            : ExpandableText(
                                textAlign: TextAlign.justify,
                                item.descricao,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withAlpha(190),
                                    fontSize: 12),
                                expandText: 'Mostrar +',
                                collapseText: 'Mostrar -',
                                maxLines: 1,
                                //linkColor: Colors.blue,
                              ),
                        Row(children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              '${item.medida == 'uni' ? item.quantidade.toStringAsFixed(0) : item.quantidade.toStringAsFixed(3)} ${item.medida}',
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
                              formatter.format(item.preco),
                              style: Estilos().sutil(context, tamanho: 11),
                              //textAlign: TextAlign.end,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: Text(
                              '=',
                              style: Estilos().sutil(context, tamanho: 9),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              formatter.format(item.quantidade * item.preco),
                              style: Estilos().sutil(context, tamanho: 11),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ]),
                      ]),
                ),
              ),
            ),
            Expanded(
              child: Checkbox(
                  value: item.comprado == 0 ? false : true,
                  onChanged: (value) {
                    if (value != null) {
                      item.comprado = value ? 1 : 0;
                      itemC.marcarDesmarcarItem(item, lista);
                    }
                  }),
            ),
          ]),
        ),
      );
    });
  }

  TextStyle itemComCheck(context) {
    return TextStyle(
      decoration: TextDecoration.lineThrough,
      decorationThickness: 1,
      fontSize: 18,
      color: Theme.of(context).colorScheme.onBackground.withAlpha(130),
      overflow: TextOverflow.ellipsis,
    );
  }
}
