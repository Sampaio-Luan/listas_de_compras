import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../constants/const_strings_globais.dart';
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
                child: _label(context, label: kComprados),
                onTap: () {
                  if (itemOuLista == 'item') {
                    itemC.filtrarItens(kComprados);
                  }
                },
              ),
              PopupMenuItem(
                child: _label(context, label: kAComprar),
                onTap: () {
                  if (itemOuLista == 'item') {
                    itemC.filtrarItens(kAComprar);
                  }
                },
              ),
            ]);
  }

  _label(context, {required String label}) {
    const double tamanho = 30;
    Map<String, Widget> labels = {
      kComprados: Icon(
        PhosphorIconsRegular.checkSquare,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      kAComprar: Icon(
        PhosphorIconsRegular.square,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      kTodos: Icon(
        PhosphorIconsRegular.listBullets,
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
