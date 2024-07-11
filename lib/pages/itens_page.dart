import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import 'package:listas_de_compras/widgets/formulario_item.dart';

import '../controllers/itens_controller.dart';
import '../models/item.module.dart';
import '../models/lista.module.dart';
import '../repositories/itens_repository.dart';
import '../theme/estilos.dart';
import '../widgets/layout_item.dart';
import '../widgets/painel_controle.dart';

class ItensPage extends StatefulWidget {
  final ListaModel lista;

  const ItensPage({super.key, required this.lista});

  @override
  State<ItensPage> createState() => _ItensPageState();
}

class _ItensPageState extends State<ItensPage> {
  ItensController itensController = ItensController();

  
@override
  void initState() {
   
    super.initState();
    itensController.iniciarController(idLista: widget.lista.id);
    itensController.idLista = widget.lista.id;
  }
 
  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<ItensRepository>();
    //final ictrl = context.read<ItensController>();
    
  //ctrl.recuperarItens(widget.lista.id);
    return Scaffold(
      appBar: _appBar(titulo: widget.lista.nome),
      body: Column(children: [
        ctrl.itens.isEmpty
            ? Container()
            : const Expanded(
                child: PainelControle(
                  itemOuLista: 'item',
                ),
              ),
        Expanded(
          flex: 15,
          child: Column(children: [
            Consumer<ItensRepository>(builder: (context, controle, _) {
              final itens = controle.itens;
              debugPrint('itens page: ${itens.length}');

              return itens.isEmpty
                  ? _indicadorDeProgresso()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: itens.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LayoutItem(item: itens[index]);
                        },
                      ),
                    );
            }),
          ]),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(children: [
              Text(
                "Total: ${ctrl.itens.length} itens",
                style: Estilos().tituloColor(
                  context,
                  tamanho: 'g',
                ),
              ),
            ]),
          ),
        ),
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

  _indicadorDeProgresso() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.4,
          horizontal: MediaQuery.of(context).size.width * 0.3),
      child: const CircularProgressIndicator(),
    );
  }
}
