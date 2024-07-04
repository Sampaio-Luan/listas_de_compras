import 'package:flutter/material.dart';
import 'package:listas_de_compras/theme/estilos.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: Estilos().titulo(context, tamanho: 'g'),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Titulo Colorido grande',
                style: Estilos().tituloColor(context, tamanho: 'g'),
              ),
              Text(
                'Titulo Colorido medio',
                style: Estilos().tituloColor(context, tamanho: 'm'),
              ),
              Text(
                'Titulo Colorido pequeno',
                style: Estilos().tituloColor(context, tamanho: 'p'),
              ),
              Text(
                'titulo grande',
                style: Estilos().titulo(context, tamanho: 'g'),
              ),
              Text(
                'titulo medio',
                style: Estilos().titulo(context, tamanho: 'm'),
              ),
              Text(
                'titulo pequeno',
                style: Estilos().titulo(context, tamanho: 'p'),
              ),
              Text(
                'Corpo Colorido grande',
                style: Estilos().corpoColor(context, tamanho: 'g'),
              ),
              Text(
                'corpo Colorido medio',
                style: Estilos().corpoColor(context, tamanho: 'm'),
              ),
              Text(
                'corpo Colorido pequeno',
                style: Estilos().corpoColor(context, tamanho: 'p'),
              ),
              Card.outlined(
               
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      'corpo grande',
                      style: Estilos().corpo(context, tamanho: 'g'),
                    ),
                    Text(
                      'corpo medio',
                      style: Estilos().corpo(context, tamanho: 'm'),
                    ),
                    Text(
                      'corpo pequeno',
                      style: Estilos().corpo(context, tamanho: 'p'),
                    ),
                  ]),
                ),
              ),
              Text(
                'label Color grande',
                style: Estilos().labelColor(context, tamanho: 'g'),
              ),
              Text(
                'label Color medio',
                style: Estilos().labelColor(context, tamanho: 'm'),
              ),
              Text(
                'label Color grande',
                style: Estilos().labelColor(context, tamanho: 'p'),
              ),
              Text(
                'label grande',
                style: Estilos().label(context, tamanho: 'g'),
              ),
              Text(
                'label medio',
                style: Estilos().label(context, tamanho: 'm'),
              ),
              Text(
                'label pequena',
                style: Estilos().label(context, tamanho: 'p'),
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'principal');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
