import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import 'package:listas_de_compras/widgets/opcoes_modificacao.dart';

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
      body: Consumer<HistoricoRepository>(
        builder: (context, historicoR, _) {
          return historicoR.getHistoricos.isEmpty
              ? const Center(
                  child: Text('Nenhum histórico encontrado'),
                )
              : ListView.builder(
                  itemCount: historicoR.getHistoricos.length,
                  itemBuilder: (context, index) {
                    return _layoutHistorico(
                        context, historicoR.getHistoricos[index]);
                  },
                );
        },
      ),
    );
  }

  _layoutHistorico(context, historico) {
    return Card.outlined(
      elevation: 0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        leading: CircleAvatar(
          radius: 27,
          child: Icon(PhosphorIconsRegular.moneyWavy,
              size: 30, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(
          historico.titulo,
          style: Estilos().tituloColor(context, tamanho: 'p'),
        ),
        subtitle:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _linhaComIcone(context, formatter.format(historico.total), 1),
          _linhaComIcone(context, historico.data, 0),
        ]),
        trailing: OpcoesModificacao(
          historico: historico,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VisualizarItensHistorico(
                historico: historico,
              ),
            ),
          );
        },
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
        size: 20,
        color: Theme.of(context).colorScheme.primary,
      ),
      const SizedBox(width: 8),
      Text(
        label,
        style: Estilos().sutil(
          context,
          tamanho: 14,
        ),
      ),
    ]);
  }
}
