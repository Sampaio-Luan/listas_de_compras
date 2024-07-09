import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../theme/estilos.dart';

class OpcoesFiltros extends StatelessWidget {
  final String itemOuLista;

  const OpcoesFiltros({super.key, required this.itemOuLista});

  @override
  Widget build(BuildContext context) {
    final itemC = context.watch<ItensController>();
    return PopupMenuButton<dynamic>(
        padding: const EdgeInsets.all(0),
        icon: const Icon(
        PhosphorIconsRegular.funnel,
      ),
        position: PopupMenuPosition.under,
        elevation: 1,
        itemBuilder: (context) => [
              PopupMenuItem(
                child: _label(context, label: 'Comprados'),
                onTap: () {
                  if (itemOuLista == 'item') {
                    itemC.filtrarItens('Comprados');
                  }
                },
              ),
              PopupMenuItem(
                child: _label(context, label: 'A comprar'),
                onTap: () {
                  if (itemOuLista == 'item') {
                    itemC.filtrarItens('A comprar');
                  }
                },
              ),
            ]);
  }

  _label(context, {required String label}) {
    const double tamanho = 30;
    Map<String, Widget> labels = {
      'Comprados': Icon(
        PhosphorIconsRegular.checkSquare,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'A comprar': Icon(
        PhosphorIconsRegular.square,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
    };
  return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: Text(
          label,
          style: Estilos().corpoColor(context, tamanho: 'p'),
        ),
      ),
      trailing: labels[label]!,
    );
  }
}
