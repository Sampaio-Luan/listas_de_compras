import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../models/item.module.dart';
import '../models/item_historico.module.dart';
import '../repositories/historico_repository.dart';
import '../repositories/itens_historico_repository.dart';
import '../theme/estilos.dart';

import 'visualizar_itens_historico.dart';

class HistoricoPage extends StatelessWidget {
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
  HistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemHR = context.watch<ItensHistoricoRepository>();
    final itemC = context.watch<ItensController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Históricos',
        ),
        centerTitle: true,
        backgroundColor:
            Theme.of(context).colorScheme.brightness == Brightness.light
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primaryContainer,
        foregroundColor:
            Theme.of(context).colorScheme.brightness == Brightness.light
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: Consumer<HistoricoRepository>(builder: (context, historicoR, _) {
        return historicoR.getHistoricos.isEmpty
            ? const Center(
                child: Text('Nenhum histórico encontrado'),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: historicoR.getHistoricos.length,
                itemBuilder: (context, index) {
                  return _layoutHistorico(
                      context, historicoR.getHistoricos[index]);

                  // _layoutHistorico(
                  //     context, historicoR.getHistoricos[index]);
                });
      }),
    );
  }

  _layoutHistorico(context, historico) {
    List<IconData> icones = [
      PhosphorIconsRegular.moneyWavy,
      PhosphorIconsRegular.calendar,
      PhosphorIconsRegular.heart,
    ];
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    VisualizarItensHistorico(historico: historico)));
      },
      child: Card(
        child: Column(children: [
          Expanded(
            child: CircleAvatar(
              radius: 70,
              child: Icon(
                PhosphorIconsRegular.moneyWavy,
                size: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(children: [
              Text(
                historico.titulo,
                style: Estilos().tituloColor(
                  context,
                  tamanho: 'm',
                ),
              ),
              _linhaComIcone(context, historico.data, 0),
              _linhaComIcone(context, formatter.format(historico.total), 1),
              _linhaComIcone(context, historico.id.toString(), 1),
            ]),
          ),
        ]),
      ),
    );
  }

  _linhaComIcone(context, String label, int i) {
    List<IconData> icones = [
      PhosphorIconsRegular.calendarDots,
      PhosphorIconsRegular.wallet,
    ];

    return Row(children: [
      Icon(
        icones[i],
        size: 15,
        color: Theme.of(context).colorScheme.primary,
      ),
      Text(label)
    ]);
  }
}
