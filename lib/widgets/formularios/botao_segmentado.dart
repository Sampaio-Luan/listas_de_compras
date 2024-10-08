import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../controllers/itens_controller.dart';
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
  // int selecionada = 3;
  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.prioridadeForm.text.isNotEmpty) {
  //     selecionada = int.parse(widget.prioridadeForm.text);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final itensController = context.read<ItensController>();
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
              prioridades.nomePrioridade(int.parse(widget.prioridadeForm.text)),
              textAlign: TextAlign.start,
              style: TextStyle(
                color: prioridades
                    .prioridadeColor[int.parse(widget.prioridadeForm.text)],
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
              selectedBackgroundColor: prioridades
                  .prioridadeColor[int.parse(widget.prioridadeForm.text)],
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
            selected: <int>{int.parse(widget.prioridadeForm.text)},
            onSelectionChanged: (newSelection) {
              setState(() {
                widget.prioridadeForm.text = newSelection.first.toString();
                if (itensController.itemParaEdicaoForm != null) {
                  itensController.itemParaEdicaoForm!.prioridade =
                      int.parse(widget.prioridadeForm.text);
                }
                // selecionada = newSelection.first;
                // debugPrint('Prioridade selecionada: $selecionada');
              });
            },
          ),
        ]);
  }
}
