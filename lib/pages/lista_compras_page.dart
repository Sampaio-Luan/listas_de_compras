import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../repositories/listas_repository.dart';
import '../widgets/formulario.dart';

import 'itens_page.dart';

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
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: listasR.listas.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: ()async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ItensPage(
                              lista: listasR.listas[index],
                            ),
                          ),
                        );
                      },
                      onLongPress: () {
                        listasR.excluirLista(listasR.listas[index]);
                      },
                      child: Card.outlined(
                        color: Theme.of(context)
                            .colorScheme
                            .inversePrimary
                            .withAlpha(100),
                        //elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Formulario(
                                            lista: listasR.listas[index],
                                          );
                                        });
                                  },
                                  child: Icon(
                                    Icons.payments_outlined,
                                    size: 50,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              Text('NOME: ${listasR.listas[index].nome}'),
                              Text(
                                  'DESCRICAO: ${listasR.listas[index].descricao}'),
                              Text('ID: ${listasR.listas[index].id}'),
                              Text(
                                  'CRIACAO: ${listasR.listas[index].criacao.substring(0, 10)}'),
                              // Text('ID: ${listasR.listas[index].id}'),
                              // Text('ICONE: ${listasR.listas[index].icone}'),
                            ],
                          ),
                        ),
                      ),
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
                return const Formulario(
                  lista: null,
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
