import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../models/lista.module.dart';
import '../preferencias_usuario.dart';
import '../repositories/itens_padrao_repository.dart';
import '../theme/estilos.dart';

import 'opcoes_modificacao.dart';

class NLayoutLista extends StatelessWidget {
  final ListaModel lista;
  final fomatoData = DateFormat.yMMMd('pt_BR');

  NLayoutLista({super.key, required this.lista});

  @override
  Widget build(BuildContext context) {
    final itensController = context.read<ItensController>();
    final preferencias = context.read<PreferenciasUsuarioShared>();
    final itemRP = context.read<ItensPadraoRepository>();
    return InkWell(
      onTap: () {
        itensController.iniciarController(
            idLista: lista.id, nomeLista: lista.nome);
        preferencias.setUltimaListaVisitada(lista.id);
        itemRP.filtrarItemPadrao(0);
        itensController.setIsFormEdicao(false);
        itensController.setIsFormCompleto(false);
        itensController.setIsLimparFormulario(true);
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(3),
            color: itensController.getIdLista == lista.id
                ? Theme.of(context).colorScheme.inversePrimary.withAlpha(110)
                : null,
            child: Row(children: [
              Expanded(
                child: indicadorDeItensCoprados(
                  context,
                  qtdComprado: lista.totalComprados,
                  qtdTotal: lista.totalItens,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lista.nome,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(190),
                              fontSize: 16)),
                      Text(fomatoData.format(DateTime.parse(lista.criacao)),
                          style: Estilos().sutil(context, tamanho: 11)),
                    ]),
              ),
              Expanded(
                child: OpcoesModificacao(lista: lista),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  indicadorDeItensCoprados(
    context, {
    required int qtdTotal,
    required int qtdComprado,
  }) {
    return Column(
     
      children: [
      qtdTotal == qtdComprado && qtdTotal != 0
          ? CircleAvatar(
              radius: 13,
              backgroundColor:
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? Theme.of(context).colorScheme.primary.withAlpha(200)
                      : Theme.of(context).colorScheme.primaryContainer.withAlpha(200),
              child: Center(
                child: Icon(
                  PhosphorIconsBold.check,
                  color: Theme.of(context).colorScheme.brightness ==
                          Brightness.light
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                  size: 16,
                ),
              ),
            )
          : CircularPercentIndicator(
              radius: 13,
              lineWidth: 5.0,
              percent: qtdTotal == 0 ? 0 : (qtdComprado / qtdTotal) * 100 / 100,
              progressColor:
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primaryContainer,
              backgroundColor:
                  Theme.of(context).colorScheme.onSurface.withAlpha(80),
            ),
      Text(
        '${lista.totalComprados}/${lista.totalItens}',
        style: Estilos().sutil(context, tamanho: 11),
      ),
    ]);
  }
}
