import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:listas_de_compras/repositories/itens_repository.dart';
import 'package:listas_de_compras/widgets/formulario_item.dart';

import '../models/lista.module.dart';

class ItensPage extends StatefulWidget {
  final ListaModel lista;

  const ItensPage({super.key, required this.lista});

  @override
  State<ItensPage> createState() => _ItensPageState();
}

class _ItensPageState extends State<ItensPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lista.nome),
        centerTitle: true,
      ),
      body: Consumer<ItensRepository>(builder: (context, itensRP, _) {
       itensRP.recuperarItens(widget.lista.id);
        debugPrint("Page: ${DateTime.now().toLocal()}");
        return itensRP.itens.isEmpty
            ? const Center(
                child: Text(
                  "Adicione um Item",
                ),
              )
            : ListView.builder(
                itemCount: itensRP.itens.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card.outlined(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("NOME: ${itensRP.itens[index].nome}"),
                            Text(
                                "DESCRICAO: ${itensRP.itens[index].descricao}"),
                            Text("COMPRADO: ${itensRP.itens[index].comprado}"),
                            Text("PRECO: ${itensRP.itens[index].preco}"),
                            Text(
                                "QUANTIDADE: ${itensRP.itens[index].quantidade}"),
                            Text("INDICE: ${itensRP.itens[index].indice}"),
                            Text("ID_LISTA: ${itensRP.itens[index].idLista}"),
                            Text("ID_ITEM: ${itensRP.itens[index].idItem}"),
                          ]),
                    ),
                  );
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return FormularioItem(
                  item: null,
                  idLista: widget.lista.id,
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
