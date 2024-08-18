import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../models/historico.module.dart';
import '../models/item_historico.module.dart';
import '../repositories/itens_historico_repository.dart';

class VisualizarItensHistorico extends StatefulWidget {
  final HistoricoModel historico;

  const VisualizarItensHistorico({super.key, required this.historico});

  @override
  State<VisualizarItensHistorico> createState() => _VisualizarItensHistoricoState();
}

class _VisualizarItensHistoricoState extends State<VisualizarItensHistorico> {
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
  final ItensHistoricoRepository itensHR = ItensHistoricoRepository();
  final itensHistorico = [];
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
      appBar: AppBar(title: Text(widget.historico.titulo), centerTitle: true),
      body:  itensHistorico.isEmpty ? const Center(child: CircularProgressIndicator()) :
      Column(mainAxisSize: MainAxisSize.min, children: [
              _cabecelho(context),
              Expanded(
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
              _rodape(context),
            ])
      
    );
  }

  _texto(context, String texto) => Text(
        texto,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );

  _cabecelho(context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          Expanded(flex: 2, child: _texto(context, 'ITEM')),
          Expanded(child: _texto(context, 'QTD')),
          Expanded(child: _texto(context, 'UDM')),
          Expanded(child: _texto(context, 'PREÇO')),
          Expanded(child: _texto(context, 'TOTAL')),
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
          Expanded(flex: 2, child: Text(itemH.nome)),
          Expanded(
            child: Text(
              itemH.medida == 'uni'
                  ? itemH.quantidade.toStringAsFixed(0)
                  : itemH.quantidade.toStringAsFixed(3),
            ),
          ),
          Expanded(
            child: Text(
              itemH.medida,
            ),
          ),
          Expanded(
            child: Text(
              itemH.preco.toString(),
            ),
          ),
          Expanded(
            child: Text(
              formatter.format(
                itemH.preco * itemH.quantidade,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _rodape(context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer.withAlpha(100),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          Expanded(flex: 2, child: Text('ITEM')),
          Expanded(child: Text('QTD')),
          Expanded(child: Text('UDM')),
          Expanded(child: Text('R\$')),
          Expanded(child: Text('TOTAL')),
        ]),
      ),
    );
  }
}
