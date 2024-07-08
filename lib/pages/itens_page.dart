import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:listas_de_compras/repositories/itens_repository.dart';
import 'package:listas_de_compras/theme/estilos.dart';
import 'package:listas_de_compras/widgets/formulario_item.dart';

import '../controllers/itens_controller.dart';
import '../models/lista.module.dart';
import '../widgets/layout_item.dart';

class ItensPage extends StatefulWidget {
  final ListaModel lista;

  const ItensPage({super.key, required this.lista});

  @override
  State<ItensPage> createState() => _ItensPageState();
}

class _ItensPageState extends State<ItensPage> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    final itemC = context.read<ItensController>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lista.nome),
        centerTitle: true,
      ),
      body: Consumer<ItensRepository>(builder: (context, itensRP, _) {
        itemC.calculaTotal(itensRP.itens);
        debugPrint("Page: ${DateTime.now().toLocal()}");
        i++;
        debugPrint("Page: $i");
        return itensRP.itens.isEmpty
            ? const Center(child: Text("Adicione um Item"))
            : Column(children: [
                Expanded(
                  flex: 13,
                  child: ListView.builder(
                    itemCount: itensRP.itens.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LayoutItem(item: itensRP.itens[index]);
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Row(children: [
                      Text("Total: ${itemC.total}",
                          style: Estilos().tituloColor(context, tamanho: 'g')),
                    ]),
                  ),
                ),
              ]);
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
