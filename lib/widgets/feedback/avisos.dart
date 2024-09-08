import 'package:flutter/material.dart';

import '../../theme/estilos.dart';

class Avisos {
  Estilos estilo = Estilos();
  informativo(BuildContext context, String mensagem) async {
    final resposta = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Atenção !!!',
            style: estilo.tituloColor(context, tamanho: 'g'),
            textAlign: TextAlign.center,
          ),
          content: Text(mensagem, style: estilo.corpo(context, tamanho: 'p')),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: const Text('Estou ciente'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            )
          ],
          actionsAlignment: MainAxisAlignment.spaceBetween,
        );
      },
    );

    return resposta;
  }

  observacao(BuildContext context, String mensagem) async {
    final resposta = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(
              'Observação !!!',
              style: estilo.tituloColor(context, tamanho: 'g'),
              textAlign: TextAlign.center,
            ),
            content: Text(mensagem, style: estilo.corpo(context, tamanho: 'p')),
            actions: <Widget>[
              TextButton(
                child: const Text('Entendido'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ]);
      },
    );

    return resposta;
  }
}
