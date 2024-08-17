import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../models/item.module.dart';
import '../models/item_historico.module.dart';
import '../repositories/historico_repository.dart';
import '../repositories/itens_historico_repository.dart';

class HistoricoPage extends StatelessWidget {
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
  HistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemHR = context.watch<ItensHistoricoRepository>();
    final itemC = context.watch<ItensController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Históricos',
        ),
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
      body: Consumer<HistoricoRepository>(builder: (context, historicoR, _) {
        return
            //  historicoR.getHistoricos.isEmpty
            //     ? const Center(
            //         child: Text('Nenhum historico encontrado'),
            //       )
            //     :
            ListView.separated(
                itemBuilder: (itemContext, index) =>
                    ExpansionTile(title: Text('Historico $index'), children: [
                      SizedBox(
                       height: MediaQuery.of(context).size.height * 0.5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          _cabecelho(context),
                          Expanded(
                            child: ListView.separated(
                              // itemCount: itemHR.getItensHistoricos.length,
                              itemCount: itemC.itens.length,
                              itemBuilder: (context, index) {
                                return _item2(context,
                                    itemM: itemC.itens[index]);

                                //_item(context,itemH: itemHR.getItensHistoricos[index]);
                              },
                              separatorBuilder: (itemContext, index) =>
                                  const Divider(
                                height: 0,
                              ),
                            ),
                          ),
                          _rodape(context),
                        ]),
                      ),
                    ]),
                separatorBuilder: (itemContext, index) => const Divider(),
                itemCount: 30);
      }),
    );
  }
_texto(context, String texto) => Text(texto, style:  TextStyle(color: Theme.of(context).colorScheme.onPrimary));
  _cabecelho(context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          Expanded(flex: 2, child: _texto(context,'ITEM')),
          Expanded(child: _texto(context,'QTD')),
          Expanded(child: _texto(context,'UDM')),
          Expanded(child: _texto(context,'PREÇO')),
          Expanded(child: _texto(context,'TOTAL')),
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
              child: Text(itemH.medida == 'uni'
                  ? itemH.quantidade.toStringAsFixed(0)
                  : itemH.quantidade.toStringAsFixed(3))),
          Expanded(child: Text(itemH.medida)),
          Expanded(child: Text(itemH.preco.toString())),
          Expanded(
              child: Text(formatter.format(itemH.preco * itemH.quantidade))),
        ]),
      ),
    );
  }

  _item2(context, {required ItemModel itemM}) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer.withAlpha(40),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          Expanded(flex: 2, child: Text('${itemM.nome} : ${itemM.idCategoria}')),
          Expanded(
              child: Text(itemM.medida == 'uni'
                  ? itemM.quantidade.toStringAsFixed(0)
                  : itemM.quantidade.toStringAsFixed(3))),
          Expanded(child: Text(itemM.medida)),
          Expanded(child: Text(itemM.preco.toString())),
          Expanded(
              child: Text(formatter.format(itemM.preco * itemM.quantidade))),
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
