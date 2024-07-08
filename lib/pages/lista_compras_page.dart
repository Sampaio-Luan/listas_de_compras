import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../repositories/listas_repository.dart';
import '../widgets/formulario_lista.dart';
import '../widgets/layout_lista.dart';



class ListasDeComprasPage extends StatefulWidget {
  const ListasDeComprasPage({super.key});

  @override
  State<ListasDeComprasPage> createState() => _ListasDeComprasPageState();
}

class _ListasDeComprasPageState extends State<ListasDeComprasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Listas",
        ),
        centerTitle: true,
      ),
      body: Consumer<ListasRepository>(builder: (context, listasR, _) {
        return listasR.listas.isEmpty
            ? const Center(
                child: Text(
                  "Adicione uma Lista",
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(6.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: listasR.listas.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
