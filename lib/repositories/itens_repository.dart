import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../constants/db_constants.dart';
import '../database/banco.dart';
import '../models/item.module.dart';

class ItensRepository extends ChangeNotifier {
  final List<ItemModel> _itens = [];
  List<ItemModel> get itens => _itens;

  final Map<int, List<ItemModel>> _itensPorLista = {};
  Map<int, List<ItemModel>> get itensPorLista => _itensPorLista;

  late Database db;

  ItensRepository() {
    recuperarItens(-1);
  }

 recuperarItens(int idLista) async {
    db = await Banco.instancia.database;
    _itens.clear();
    final List<Map<String, dynamic>> itensMap = await db.query(
      itemTableName,
      where: "$itemColumnListaId = ?",
      whereArgs: [idLista],
    );
    debugPrint("$itensMap");
    for (int i = 0; i < itensMap.length; i++) {
      _itens.add(
        ItemModel(
          idItem: itensMap[i][itemColumnId],
          idLista: itensMap[i][itemColumnListaId],
          nome: itensMap[i][itemColumnName],
          descricao: itensMap[i][itemColumnDescricao],
          quantidade:
              double.parse(itensMap[i][itemColumnQuantidade].toString()),
          preco: double.parse(itensMap[i][itemColumnPreco].toString()),
          comprado: itensMap[i][itemColumnComprado],
          indice: itensMap[i][itemColumnIndice],
        ),
      );
    }
    for (int i = 0; i < _itens.length; i++) {
      debugPrint("${_itens[i]}");
    }
    debugPrint("Repository: ${DateTime.now()}");

    _organizarItemPorLista();
    notifyListeners();
    return _itens;
  }

  _organizarItemPorLista() {
    _itensPorLista.clear();
    for (var item in _itens) {
      if (_itensPorLista.containsKey(item.idLista)) {
        _itensPorLista[item.idLista]!.add(item);
      } else {
        _itensPorLista[item.idLista] = [item];
      }
    }
  }

  inserirItem(ItemModel item) async {
    db = await Banco.instancia.database;
    final id = await db.insert(
      itemTableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint("Vai tomar:    $id");
    recuperarItens(item.idLista);
  }

  atualizarItem(ItemModel item) async {
    db = await Banco.instancia.database;
    await db.update(
      itemTableName,
      item.toMap(),
      where: "$itemColumnId = ?",
      whereArgs: [item.idItem],
    );
    recuperarItens(item.idLista);
  }

  excluirItem(ItemModel item) async {
    db = await Banco.instancia.database;
    await db.delete(
      itemTableName,
      where: "$itemColumnId = ?",
      whereArgs: [item.idItem],
    );
    recuperarItens(item.idLista);
  }
}
