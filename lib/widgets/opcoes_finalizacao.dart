import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../preferencias_usuario.dart';
import '../theme/estilos.dart';

import 'feedback/avisos.dart';
import 'formularios/form_historico.dart';
import 'opcoes_compartlhar_lista.dart';

class OpcoesFinalizacao extends StatelessWidget {
  final Avisos avisos = Avisos();
  OpcoesFinalizacao({super.key});

  @override
  Widget build(BuildContext context) {
    final itemC = context.read<ItensController>();
    final preferenciaR = context.watch<PreferenciasUsuarioShared>();

    //final j = context.watch<ItensPadraoRepository>();

    return PopupMenuButton<dynamic>(
        padding: const EdgeInsets.all(0),
        position: PopupMenuPosition.under,
        elevation: 1,
        constraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width * 0.6),
        icon: const Icon(
          PhosphorIconsRegular.faders,
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: _label(context,
                    label: 'Compartilhar lista',
                    icone: 'Compartilhar',
                    preferenciaRp: preferenciaR),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => const OpcoesCompartilharLista());
                },
              ),
              PopupMenuItem(
                child: _label(context,
                    label: 'Salvar no histórico',
                    icone: 'Salvar',
                    preferenciaRp: preferenciaR),
                onTap: () {
                  if (itemC.totalItensComprados == 0) {
                    avisos.observacao(context, 'Para salvar histórico de compras ao menos 1 item da lista deve estar com check(✅).',);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => const FormHistorico(
                        historico: null,
                      ),
                    );
                  }
                },
              ),
              PopupMenuItem(
                child: ExpansionTile(
                    title: Text(
                      'Visualizar Itens',
                      style: Estilos().corpoColor(context, tamanho: 'p'),
                    ),
                    children: [
                      PopupMenuItem(
                        child: _label(context,
                            label: 'Padrão',
                            icone: 'Padrao',
                            preferenciaRp: preferenciaR),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: _label(context,
                            label: 'Categoria',
                            icone: 'Categoria',
                            preferenciaRp: preferenciaR),
                        onTap: () {},
                      ),
                    ]),
              ),
            ]);
  }

  _label(context,
      {required String label,
      String? icone,
      required PreferenciasUsuarioShared? preferenciaRp}) {
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
      'Compartilhar': Icon(
        PhosphorIconsRegular.shareNetwork,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
    };
    return ListTile(
      leading: (icone != 'Padrao' && icone != 'Categoria')
          ? null
          : Checkbox(
              value: icone == 'Categoria' && preferenciaRp!.verPorCategoria ||
                  icone == 'Padrao' && !preferenciaRp!.verPorCategoria,
              onChanged: (_) {
                preferenciaRp!
                    .setVerPorCategoria(!preferenciaRp.verPorCategoria);
                Navigator.of(context).pop();
              }),
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
