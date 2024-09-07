import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import '../models/historico.module.dart';
import '../models/item_historico.module.dart';
import '../repositories/itens_historico_repository.dart';
import '../theme/estilos.dart';

class VisualizarItensHistorico extends StatefulWidget {
  final HistoricoModel historico;

  const VisualizarItensHistorico({super.key, required this.historico});

  @override
  State<VisualizarItensHistorico> createState() =>
      _VisualizarItensHistoricoState();
}

class _VisualizarItensHistoricoState extends State<VisualizarItensHistorico> {
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
  final ItensHistoricoRepository itensHR = ItensHistoricoRepository();
  final itensHistorico = [];
  //final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _preencher();
  }

  _preencher() async {
    final itemH = await itensHR.recuperarItensHistoricos(widget.historico.id);
    setState(() {
      itensHistorico.clear();
      itensHistorico.addAll(itemH);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final itensHR = context.read<ItensHistoricoRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.historico.titulo),
        centerTitle: true,
       backgroundColor:
              Theme.of(context).colorScheme.brightness == Brightness.light
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primaryContainer,
          foregroundColor:
              Theme.of(context).colorScheme.brightness == Brightness.light
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: itensHistorico.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(mainAxisSize: MainAxisSize.min, children: [
              _cabecelho(context),
              Expanded(
                child: Scrollbar(
                  // controller: _scrollController,
                  thumbVisibility: true,
                  thickness: 5,
                  radius: const Radius.circular(20),
                  //trackVisibility: true,

                  child: ListView.separated(
                    // itemCount: itemHR.getItensHistoricos.length,
                    itemCount: itensHistorico.length,
                    itemBuilder: (context, index) {
                      return _item(context, itemH: itensHistorico[index]);

                      //_item(context,itemH: itemHR.getItensHistoricos[index]);
                    },
                    separatorBuilder: (itemContext, index) => const Divider(
                      height: 0,
                    ),
                  ),
                ),
              ),
              _rodape(context),
            ]),
    );
  }

  _texto(context, String texto) => Text(
        texto,
        style: Estilos().tituloColor(context, tamanho: 'p'),
        textAlign: TextAlign.center,
      );

  _cabecelho(context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          _texto(context, 'ITEM'),
          
          _texto(context, 'QTD'),
          _texto(context, 'R\$'),
          _texto(context, 'TOTAL'),
          // Expanded(
          //   flex: 3,
          //   child: Text(
          //     'Total',
          //     style: Estilos().tituloColor(context, tamanho: 'p'),
          //     //textAlign: TextAlign.center,
          //   ),
          // ),
        ]),
      ),
    );
  }

  _item(context, {required ItemHistoricoModel itemH}) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer.withAlpha(30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          Expanded(flex: 4, child: Text(itemH.nome)),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                itemH.medida == 'uni'
                    ? itemH.quantidade.toStringAsFixed(0)
                    : itemH.quantidade.toStringAsFixed(3),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              itemH.preco.toString(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: Text(
                itemH.total.toStringAsFixed(2),
                //textAlign: TextAlign.end,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _rodape(context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer.withAlpha(150),
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '${itensHistorico.length} itens',
            style: Estilos().tituloColor(context, tamanho: 'p'),
            textAlign: TextAlign.end,
          ),
          Text(
            formatter.format(widget.historico.total),
            style: Estilos().tituloColor(context, tamanho: 'p'),
            textAlign: TextAlign.end,
          ),
        ]),
      ),
    );
  }
}
