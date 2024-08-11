import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../controllers/itens_controller.dart';

class BotaoSegmentadoMedidada extends StatefulWidget {
  final TextEditingController medida;
  final TextEditingController valor;
  const BotaoSegmentadoMedidada(
      {super.key, required this.medida, required this.valor});

  @override
  State<BotaoSegmentadoMedidada> createState() =>
      _BotaoSegmentadoMedidadaState();
}

class _BotaoSegmentadoMedidadaState extends State<BotaoSegmentadoMedidada> {
  @override
  void initState() {
    super.initState();
    if (widget.medida.text.isEmpty) {
      widget.medida.text = 'uni';
    }
  }

  @override
  Widget build(BuildContext context) {
    final itensController = context.read<ItensController>();

   

    return SegmentedButton<String>(
        showSelectedIcon: false,
        style: SegmentedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            selectedBackgroundColor: Theme.of(context).colorScheme.primary,
            selectedForegroundColor: Theme.of(context).colorScheme.onPrimary,
            padding: const EdgeInsets.all(0)),
        segments: const <ButtonSegment<String>>[
          ButtonSegment<String>(
            value: 'uni',
            label: Text('Uni'),
          ),
          ButtonSegment<String>(
            value: 'kg',
            label: Text('Kg'),
          ),
        ],
        selected: <String>{widget.medida.text},
        onSelectionChanged: (Set<String> newSelection) {
          setState(() {
            widget.medida.text = newSelection.first;
         

          if (widget.medida.text == 'uni') {
            double quantidade = widget.valor.text.isEmpty
                ? 1
                : double.parse(widget.valor.text.replaceAll(',', '.'));
            widget.valor.text = quantidade.toStringAsFixed(0);
            itensController.setIsUnidade(true);
          } else {
            widget.valor.text = '0,${widget.valor.text}';
            itensController.setIsUnidade(false);
          }
          
          debugPrint('SegmentedButton unidade de medida: ${widget.medida.text}'); });
        });
  }
}
