import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/categoria.module.dart';
import '../repositories/categorias_repository.dart';
import '../theme/estilos.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  List<CategoriaModel> categorias = [];

  // reorder method
  _reordenarCategorias(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      final CategoriaModel cat = categorias.removeAt(oldIndex);

      categorias.insert(newIndex, cat);
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoriaR = context.watch<CategoriasRepository>();
    //categoriaR.recuperarCategorias();
    categorias = categoriaR.getCategorias;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        centerTitle: true,
        backgroundColor:
            Theme.of(context).colorScheme.brightness == Brightness.light
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primaryContainer,
        foregroundColor:
            Theme.of(context).colorScheme.brightness == Brightness.light
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: Column(children: [
        categorias.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17.0, vertical: 5),
                  child: Text(
                      'Ordene os titulos abaixo para definir a ordem de exibição por categoria.',
                      style: Estilos().sutil(context, tamanho: 14),
                      textAlign: TextAlign.justify),
                ),
              ),
        const Divider(
          height: 3,
          thickness: 0.5,
        ),
        Expanded(
          child: ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            children: [
              for (int i = 0; i < categorias.length; i++)
                ListTile(
                  key: ValueKey(categorias[i]),
                  title: Row(
                    children: [
                      Text(categorias[i].nome,
                          style: Estilos().tituloColor(context, tamanho: 'p')),
                          Text(' id: (${categorias[i].id}) grau: (${categorias[i].grau})',)
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withAlpha(20),
                    child: Text((i + 1).toString()),
                  ),
                  trailing: const Icon(Icons.drag_handle),
                ),
            ],
            onReorder: (oldIndex, newIndex) {
              _reordenarCategorias(oldIndex, newIndex);
              debugPrint('oldIndex: $oldIndex newIndex: $newIndex');
              List<CategoriaModel> editCategoria = [];
              for(int j = 0; j < categorias.length; j++){
               CategoriaModel editarCat = categorias[j];
               editarCat.grau = j;
               editCategoria.add(editarCat);
              }
              categoriaR.editarCategorias(editCategoria);
            },
          ),
        ),
      ]),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor:
            Theme.of(context).colorScheme.brightness == Brightness.light
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primaryContainer,
        foregroundColor:
            Theme.of(context).colorScheme.brightness == Brightness.light
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onPrimaryContainer,
        child: const Icon(Icons.add),
      ),
    );
  }
}
