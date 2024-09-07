import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../theme/estilos.dart';
import 'package:provider/provider.dart';

import '../preferencias_usuario.dart';

class OpcoesTemaCores extends StatefulWidget {
  const OpcoesTemaCores({super.key});

  @override
  State<OpcoesTemaCores> createState() => _OpcoesTemaCoresState();
}

class _OpcoesTemaCoresState extends State<OpcoesTemaCores> {
  Map<int, Color> cores = {
    0: Colors.indigo,
    1: Colors.green.shade900,
    2: Colors.amber.shade700,
    //2: Colors.amber,
    3: Colors.pink.shade800,
  };

  List<String> nomes = ['Azul', 'Verde', 'Amarelo', 'Rosa'];

  @override
  Widget build(BuildContext context) {
    final preferencias = context.watch<PreferenciasUsuarioShared>();
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 2,
      title: Text(
        'Tema de cores',
        style: Estilos().tituloColor(context, tamanho: 'g'),
        textAlign: TextAlign.center,

      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.07,
        child: GridView.builder(
          itemCount: cores.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                preferencias.setTemaDeCores(index);
                setState(() {});
              },
              child: Icon(
                preferencias.temaDeCores == index
                    ? PhosphorIconsFill.clipboardText
                    : PhosphorIconsRegular.clipboardText,
                color: cores[index]!.withAlpha(200),
                size: 45,
              ),
            );
          },
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            
            elevation: 1,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'OK',
            style: Estilos().corpoColor(context, tamanho: 'm'),
          ),
        ),
      ],
    );
  }
}
