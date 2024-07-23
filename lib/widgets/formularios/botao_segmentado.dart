import 'package:flutter/material.dart';

import '../../models/prioridades.module.dart';
import '../../theme/estilos.dart';

class BotaoSegmentado extends StatefulWidget {
  final TextEditingController prioridadeForm;
  const BotaoSegmentado({super.key, required this.prioridadeForm});

  @override
  State<BotaoSegmentado> createState() => _BotaoSegmentadoState();
}

class _BotaoSegmentadoState extends State<BotaoSegmentado> {
  final prioridades = Prioridades();
  int selecionada = 3;
  @override
  void initState() {
    super.initState();
    if (widget.prioridadeForm.text.isNotEmpty) {
      selecionada = int.parse(widget.prioridadeForm.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Prioridade:',
              style: Estilos().sutil(context, tamanho: 12),
            ),
            const SizedBox(width: 5),
            Text(
              prioridades.nomePrioridade(selecionada),
              textAlign: TextAlign.start,
              style: TextStyle(
                color: prioridades.prioridadeColor[selecionada],
                fontSize: 12,
              ),
            ),
          ]),
          SegmentedButton<int>(
            showSelectedIcon: false,
            style: SegmentedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              selectedBackgroundColor: prioridades.prioridadeColor[selecionada],
              selectedForegroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            segments: const <ButtonSegment<int>>[
              ButtonSegment<int>(
                value: 0,
                label: Text('A'),
              ),
              ButtonSegment<int>(
                value: 1,
                label: Text('M'),
              ),
              ButtonSegment<int>(
                value: 2,
                label: Text('B'),
              ),
              ButtonSegment<int>(
                value: 3,
                label: Text('N'),
              ),
            ],
            selected: <int>{selecionada},
            onSelectionChanged: (newSelection) {
              setState(() {
                widget.prioridadeForm.text = newSelection.first.toString();
                selecionada = newSelection.first;
                debugPrint('Prioridade selecionada: $selecionada');
              });
            },
          ),
        ]);
  }
}
