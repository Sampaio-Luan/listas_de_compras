import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:listas_de_compras/widgets/formulario_item.dart';

import '../controllers/itens_controller.dart';
import '../models/lista.module.dart';

class ItensPage extends StatefulWidget {
  final ListaModel lista;

  const ItensPage({super.key, required this.lista});

  @override
  State<ItensPage> createState() => _ItensPageState();
}

class _ItensPageState extends State<ItensPage> {
  @override
  void initState() {
    super.initState();
    _recuperarItens();
  }

  _recuperarItens() async {
    final itensCTL = Provider.of<ItensController>(context, listen: true);
    itensCTL.recuperarItens(context, widget.lista.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lista.nome),
        centerTitle: true,
      ),
      body: Consumer<ItensController>(builder: (context, itensCTL, _) {
        return itensCTL.itensDaLista.isEmpty
            ? const Center(
                child: Text(
                  "Adicione um Item",
                ),
              )
            : ListView.builder(
                itemCount: itensCTL.itensDaLista.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(itensCTL.itensDaLista[index].nome),
                    subtitle: Text(itensCTL.itensDaLista[index].descricao),
                  );
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FormularioItem(
                idLista: widget.lista.id,
                item: null,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
