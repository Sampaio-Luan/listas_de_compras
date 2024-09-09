import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../models/categoria.module.dart';
import '../repositories/categorias_repository.dart';
import '../theme/estilos.dart';
import '../widgets/formularios/form_categoria.dart';
import '../widgets/opcoes_modificacao.dart';

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
                  : Theme.of(context).colorScheme.onPrimaryContainer,),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       showDialog(
          //           context: context,
          //           builder: (context) => FormularioCategoria(categoria: null));
          //     },
          //     icon: Icon(
          //       PhosphorIconsDuotone.listPlus,
          //       color:
          //           Theme.of(context).colorScheme.brightness == Brightness.light
          //               ? Theme.of(context).colorScheme.onPrimary
          //               : Theme.of(context).colorScheme.onPrimaryContainer,
          //     ),
          //   ),
          // ]),
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
                      'Ordene os títulos pressionando e arrastando para definir a ordem de exibição dos itens por categoria.',
                      style: Estilos().sutil(context, tamanho: 14),
                      textAlign: TextAlign.justify),
                ),
              ),
        const Divider(height: 3, thickness: 0.5),
        Expanded(
          child: ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            children: [
              for (int i = 0; i < categorias.length; i++)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                  key: ValueKey(categorias[i].id),
                  title: Text(categorias[i].nome,
                      style: Estilos().tituloColor(context, tamanho: 'p')),
                  // subtitle: Text(
                  //   ' id: (${categorias[i].id}) grau: (${categorias[i].grau})',
                  // ),
                  leading: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.menu,
                        color: Theme.of(context).colorScheme.primary, size: 20),
                    const SizedBox(width: 20),
                    CircleAvatar(
                      radius: 17,
                      backgroundColor:
                          Theme.of(context).colorScheme.primary.withAlpha(20),
                      child: Text((i + 1).toString()),
                    ),
                  ]),
                  trailing: categorias[i].id <= 9
                      ? null
                      : OpcoesModificacao(categoria: categorias[i]),
                ),
            ],
            onReorder: (oldIndex, newIndex) {
              _reordenarCategorias(oldIndex, newIndex);
              debugPrint('oldIndex: $oldIndex newIndex: $newIndex');
              List<CategoriaModel> editCategoria = [];
              for (int j = 0; j < categorias.length; j++) {
                CategoriaModel editarCat = categorias[j];
                editarCat.grau = j;
                editCategoria.add(editarCat);
              }
              categoriaR.editarCategorias(editCategoria);
            },
          ),
        ),
        ListTile(
          tileColor: Theme.of(context).colorScheme.primary.withAlpha(200),
          contentPadding: const EdgeInsets.symmetric(horizontal: 2),
          title: const Text(
            'Adicionar categoria',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => FormularioCategoria(categoria: null));
          },
        )
      ]),
    );
  }
}
