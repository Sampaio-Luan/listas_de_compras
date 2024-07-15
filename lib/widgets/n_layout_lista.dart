import 'package:flutter/material.dart';

import 'package:expandable_text/expandable_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../models/lista.module.dart';
import '../pages/itens_page.dart';
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
        itensController.iniciarController(idLista: lista.id);
        preferencias.setUltimaListaVisitada(lista.id);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItensPage(lista: lista)),
        );
      },
      child: Container(
        color: 1 > 2
            ? Theme.of(context).colorScheme.inversePrimary.withAlpha(25)
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
                  style: Estilos().corpoColor(context, tamanho: 'p')),
              ExpandableText(
                  textAlign: TextAlign.justify,
                  lista.descricao,
                  style: Estilos().sutil(context, tamanho: 12),
                  expandText: '+',
                  collapseText: '-',
                  maxLines: 1),
              //const SizedBox(height: 5),
              Text(fomatoData.format(DateTime.parse(lista.criacao)),
                  style: Estilos().sutil(context, tamanho: 11)),
            ]),
          ),
          Expanded(
            child: OpcoesModificacao(lista: lista),
          )
        ]),
      ),
    );
  }
}
