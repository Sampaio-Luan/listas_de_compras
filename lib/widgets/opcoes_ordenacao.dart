import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../constants/const_strings_globais.dart';
import '../controllers/itens_controller.dart';
import '../theme/estilos.dart';

class OpcoesOrdenacao extends StatelessWidget {
  final String itemOuLista;

  const OpcoesOrdenacao({super.key, required this.itemOuLista});

  @override
  Widget build(BuildContext context) {
    final itemC = context.read<ItensController>();
    return PopupMenuButton<dynamic>(
        padding: const EdgeInsets.all(0),
        
        icon: const Icon(
          PhosphorIconsRegular.arrowsDownUp,
        ),
        position: PopupMenuPosition.under,
        elevation: 1,
        itemBuilder: (context) => [
              PopupMenuItem(
                child: _label(context, label: kAz),
                onTap: () {
                  if (itemOuLista == 'item') {
                    itemC.ordenarItens(kAz);
                  } else {
                    // listaC.ordenarListas(kAz);
                  }
                },
              ),
              PopupMenuItem(
                child: _label(context, label: kZa),
                onTap: () {
                  if (itemOuLista == 'item') {
                    itemC.ordenarItens(kZa);
                  } else {
                    // listaC.ordenarListas(kZa);
                  }
                },
              ),
              PopupMenuItem(
                child: _label(context, label: kCaro),
                onTap: () {
                  itemC.ordenarItens(kCaro);
                },
              ),
              PopupMenuItem(
                child: _label(context, label: kBarato),
                onTap: () {
                  itemC.ordenarItens(kBarato);
                },
              ),
              PopupMenuItem(
                child: _label(context, label: kPrioridade),
                onTap: () {
                  itemC.ordenarItens(kPrioridade);
                },
              ),
              PopupMenuItem(
                child: _label(context, label: kPadrao),
                onTap: () {
                  itemC.ordenarItens(kPadrao);
                },
              ),
            ]);
  }

  _icone(context, {required String label}) {
    const double tamanho = 30;
    Map<String, Icon> labels = {
      'A-z': Icon(
        PhosphorIconsRegular.sortAscending,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'Z-a': Icon(
        PhosphorIconsRegular.sortDescending,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      '+ Caro': Icon(
        PhosphorIconsRegular.moneyWavy,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      '+ Barato': Icon(
        PhosphorIconsRegular.coins,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'Prioridade': Icon(
        PhosphorIconsRegular.ranking,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'Padrão': Icon(
        PhosphorIconsRegular.calendarDots,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
    };

    return labels[label]!;
  }

  _label(context, {required String label}) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.9),
        child: Text(
          label,
          style: Estilos().corpoColor(context, tamanho: 'p'),
        ),
      ),
      trailing: _icone(context, label: label),
    );
  }
}
