import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/item.module.dart';
import '../repositories/itens_repository.dart';

class ItensController extends ChangeNotifier {
  final List<ItemModel> _itens = [];
  List<ItemModel> get itensDaLista => _itens;

  recuperarItens(context, int idLista) {
    final itensRP = Provider.of<ItensRepository>(context, listen: false);

    _itens.clear();
    for (var item in itensRP.itensPorLista[idLista]!) {
      _itens.add(item);
    }

    notifyListeners();
  }
}
