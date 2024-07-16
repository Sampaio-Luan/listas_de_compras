import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../models/lista.module.dart';
import '../preferencias_usuario.dart';
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
    return InkWell(
      onTap: () {
        itensController.iniciarController(
            idLista: lista.id, nomeLista: lista.nome);
        preferencias.setUltimaListaVisitada(lista.id);
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: itensController.getIdLista == lista.id
                ? Theme.of(context).colorScheme.inversePrimary.withAlpha(110)
                : null,
            child: Row(children: [
              const Expanded(child: CircleAvatar()),
              const SizedBox(width: 15),
              Expanded(
                flex: 6,
                child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(lista.nome,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha(190), fontSize: 16)),
                  Text(fomatoData.format(DateTime.parse(lista.criacao)),
                      style: Estilos().sutil(context, tamanho: 11)),
                ]),
              ),
              Expanded(child: OpcoesModificacao(lista: lista)),
            ]),
          ),
        ),
      ),
    );
  }
}
