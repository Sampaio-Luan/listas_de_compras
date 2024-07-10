import 'package:flutter/material.dart';

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
    return Row(children: [
      Expanded(child: OpcoesOrdenacao(itemOuLista: widget.itemOuLista)),
      const VerticalDivider(thickness: 2),
      Expanded(child: OpcoesFiltros(itemOuLista: widget.itemOuLista)),
      const VerticalDivider(thickness: 2),
      Expanded(
        child: Checkbox(value: false, onChanged: (_) {}),
      ),
    ]);
  }
}
