import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../preferencias_usuario.dart';
import '../repositories/listas_repository.dart';
import '../widgets/formulario_lista.dart';
import '../widgets/layout_lista.dart';

import 'drawer_lista.dart';

class ListasDeComprasPage extends StatefulWidget {
  const ListasDeComprasPage({super.key});

  @override
  State<ListasDeComprasPage> createState() => _ListasDeComprasPageState();
}

class _ListasDeComprasPageState extends State<ListasDeComprasPage> {
  @override
  Widget build(BuildContext context) {
    final preferencias = context.read<PreferenciasUsuarioShared>();
    return Scaffold(
      drawer: const DrawerListas(),
      appBar: AppBar(
          elevation: 0,
          backgroundColor:
              Theme.of(context).colorScheme.brightness == Brightness.light
                  ? Theme.of(context).colorScheme.background
                  : Theme.of(context).colorScheme.primaryContainer,
          title: const Text(
            "Listas",
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  preferencias.mudarTema();
                },
                icon: preferencias.temaEscuro
                    ? const Icon(PhosphorIconsFill.moonStars, size: 30)
                    : const Icon(PhosphorIconsDuotone.sunDim, size: 30))
          ]),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0.8, 1),
            colors: <Color>[
              Theme.of(context).colorScheme.brightness == Brightness.light
                  ? Theme.of(context).colorScheme.background
                  : Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.brightness == Brightness.light
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.background,
            ],
          ),
        ),
        child: Consumer<ListasRepository>(builder: (context, listasR, _) {
          return listasR.listas.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: listasR.listas.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      mainAxisExtent: 150,
                    ),
                    itemBuilder: (context, index) {
                      return LayoutLista(
                        lista: listasR.listas[index],
                      );
                    },
                  ),
                );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const FormularioLista(
                  lista: null,
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
