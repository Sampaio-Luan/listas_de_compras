import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../controllers/listas_controller.dart';

import 'opcoes_filtros.dart';
import 'opcoes_ordenacao.dart';

class PainelControle extends StatefulWidget {
  final String itemOuLista;

  const PainelControle({super.key, required this.itemOuLista});

  @override
  State<PainelControle> createState() => _PainelControleState();
}

class _PainelControleState extends State<PainelControle> {
  @override
  Widget build(BuildContext context) {
    final listaC = context.watch<ListasController>();
    return Consumer<ItensController>(builder: (context, itemC, _) {
      return Column(children: [
        Expanded(
          child: Row(children: [
            Expanded(child: OpcoesOrdenacao(itemOuLista: widget.itemOuLista)),
            const VerticalDivider(thickness: 0.7, width: 0),
            Expanded(
              flex: 5,
              child: itemC.filtro.isNotEmpty
                  ? ActionChip(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      avatar: const Icon(PhosphorIconsRegular.x),
                      label: Text(itemC.filtro),
                      onPressed: () {
                        itemC.filtrarItens('');
                      })
                  : OpcoesFiltros(itemOuLista: widget.itemOuLista),
            ),
            const VerticalDivider(thickness: 0.7, width: 0),
            Expanded(
              child: Checkbox(
                  value: itemC.isMarcadoTodosItens,
                  onChanged: (_) {
                    itemC.marcarTodos(listaC);
                  }),
            ),
          ]),
        ),
        const Divider(height: 0, thickness: 0.5),
      ]);
    });
  }
}
