import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../controllers/listas_controller.dart';
import '../theme/estilos.dart';

class OpcoesOrdenacao extends StatelessWidget {
  final String itemOuLista;

  const OpcoesOrdenacao({super.key, required this.itemOuLista});

  @override
  Widget build(BuildContext context) {
    final itemC = context.watch<ItensController>();
    final listaC = context.read<ListasController>();
    return PopupMenuButton<dynamic>(
        padding: const EdgeInsets.all(0),
        icon: const Icon(
          PhosphorIconsRegular.arrowsDownUp,
        ),
        position: PopupMenuPosition.under,
        elevation: 1,
        itemBuilder: (context) => [
              PopupMenuItem(
                child: _label(context, label: 'A-z'),
                onTap: () {
                  if (itemOuLista == 'item') {
                    itemC.ordenarItens('A-z');
                  } else {
                    listaC.ordenarListas('A-z');
                  }
                },
              ),
              PopupMenuItem(
                child: _label(context, label: 'Z-a'),
                onTap: () {
                  if (itemOuLista == 'item') {
                    itemC.ordenarItens('Z-a');
                  } else {
                    listaC.ordenarListas('Z-a');
                  }
                },
              ),
              PopupMenuItem(
                child: _label(context, label: '+ Caro'),
                onTap: () {
                  itemC.ordenarItens('+ Caro');
                },
              ),
              PopupMenuItem(
                child: _label(context, label: '+ Barato'),
                onTap: () {
                  itemC.ordenarItens('+ Barato');
                },
              )
            ]);
  }

  _label(context, {required String label}) {
    const double tamanho = 30;
    Map<String, Widget> labels = {
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
    };

    return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.9),
        child: Text(
          label,
          style: Estilos().corpoColor(context, tamanho: 'p'),
        ),
      ),
      trailing: labels[label]!,
    );
  }
}
