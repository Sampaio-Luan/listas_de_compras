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
import '../widgets/painel_controle.dart';

class ItensPage extends StatefulWidget {
  final ListaModel lista;

  const ItensPage({super.key, required this.lista});

  @override
  State<ItensPage> createState() => _ItensPageState();
}

class _ItensPageState extends State<ItensPage> {
  ItensController itensController = ItensController();

  int i = 0;

  @override
  void initState() {
    super.initState();
    itensController.iniciarController(idLista: widget.lista.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(titulo: widget.lista.nome),
      body: Consumer<ItensController>(builder: (context, controle, child) {
        debugPrint('itens page: ${controle.itensInterface.length}');
        return controle.itensInterface.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                const Expanded(
                  child: PainelControle(
                    itemOuLista: 'item',
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: Column(children: [
                    Expanded(
                      flex: 13,
                      child: ListView.builder(
                        itemCount: controle.itensInterface.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LayoutItem(
                              item: controle.itensInterface[index]);
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Row(children: [
                          Text("Total: ${controle.precoTotal}",
                              style:
                                  Estilos().tituloColor(context, tamanho: 'g')),
                        ]),
                      ),
                    ),
                  ]),
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

  AppBar _appBar({required String titulo}) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(titulo),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            PhosphorIconsBold.magnifyingGlass,
          ),
        ),
      ],
    );
  }
}
