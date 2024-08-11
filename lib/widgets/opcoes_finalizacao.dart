import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../theme/estilos.dart';

class OpcoesFinalizacao extends StatelessWidget {
  const OpcoesFinalizacao({super.key});

  @override
  Widget build(BuildContext context) {
    final itemC = context.read<ItensController>();

    return PopupMenuButton<dynamic>(
        padding: const EdgeInsets.all(0),
        position: PopupMenuPosition.under,
        elevation: 1,
        constraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width * 0.6),
        icon:  const Icon(
          PhosphorIconsRegular.faders,
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: _label(context,
                    label: 'Salvar no histórico', icone: 'Salvar'),
                onTap: () {},
              ),
              PopupMenuItem(
                child: ExpansionTile(
                 
                    title: Text(
                      'Visualizar Itens',
                      style: Estilos().corpoColor(context, tamanho: 'p'),
                    ),
                    children: [
                      PopupMenuItem(
                        child:
                            _label(context, label: 'Padrão', icone: 'Padrao'),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: _label(context,
                            label: 'Categoria', icone: 'Categoria'),
                        onTap: () {},
                      ),
                    ]),
              ),
            ]);
  }

  _label(context, {required String label, String? icone}) {
    const double tamanho = 25;
    Map<String, Widget> labels = {
      'Salvar': Icon(
        PhosphorIconsRegular.floppyDisk,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'Visualizacao': Icon(
        PhosphorIconsRegular.eye,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'Padrao': Icon(
        PhosphorIconsRegular.notepad,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'Categoria': Icon(
        PhosphorIconsRegular.stackPlus,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
    };
    return ListTile(
      // leading: icone == 'Salvar'
      //     ? null
      //     : Checkbox(value: icone == 'Padrao' ? true : false, onChanged: null),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: Estilos().corpoColor(context, tamanho: 'p'),
        ),
      ),
      trailing: icone == null ? labels[label] : labels[icone],
    );
  }
}
