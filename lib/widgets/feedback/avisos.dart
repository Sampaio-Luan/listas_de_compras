import 'package:flutter/material.dart';

import '../../theme/estilos.dart';

class Avisos {
  Estilos estilo = Estilos();
  informativo(BuildContext context, String mensagem) {
    showDialog(
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
                child: const Text('Entendi'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }
}
