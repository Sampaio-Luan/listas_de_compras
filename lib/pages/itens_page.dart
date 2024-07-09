import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import 'package:listas_de_compras/widgets/formulario_item.dart';

import '../controllers/itens_controller.dart';
import '../models/item.module.dart';
import '../models/lista.module.dart';
import '../theme/estilos.dart';
import '../widgets/layout_item.dart';
import '../widgets/opcoes_filtros.dart';
import '../widgets/opcoes_ordenacao.dart';

class ItensPage extends StatefulWidget {
  final ListaModel lista;

  const ItensPage({super.key, required this.lista});

  @override
  State<ItensPage> createState() => _ItensPageState();
}

class _ItensPageState extends State<ItensPage> {
  late List<ItemModel> itens;
  int i = 0;
  @override
  Widget build(BuildContext context) {
    final itemC = context.watch<ItensController>();
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.lista.nome),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(PhosphorIconsBold.magnifyingGlass)),
        ],
      ),
      body: Column(children: [
        Expanded(
          child: Row(children: [
            const Expanded(child: OpcoesOrdenacao(itemOuLista: 'item')),
            const VerticalDivider(thickness: 2),
            const Expanded(child: OpcoesFiltros(itemOuLista: 'item')),
            const VerticalDivider(thickness: 2),
            Expanded(
              child: Checkbox(value: false, onChanged: (_) {}),
            ),
          ]),
        ),
        Expanded(
            flex: 15,
            child: itemC.itemInterface.isEmpty
                ? const Center(child: Text("Adicione um Item"))
                : Column(children: [
                    Expanded(
                      flex: 13,
                      child: ListView.builder(
                        itemCount: itemC.itemInterface.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LayoutItem(item: itemC.itemInterface[index]);
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Row(children: [
                          Text("Total: ${itemC.total}",
                              style:
                                  Estilos().tituloColor(context, tamanho: 'g')),
                        ]),
                      ),
                    ),
                  ]),),
      ]),
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
