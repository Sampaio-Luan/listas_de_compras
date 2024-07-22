import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/const_tb_item_historico.dart';
import '../database/banco.dart';
import '../models/item_historico.module.dart';

class ItensHistoricoRepository extends ChangeNotifier {
  final List<ItemHistoricoModel> _itensHistoricos = [];
  List<ItemHistoricoModel> get getItensHistoricos => _itensHistoricos;

  late Database db;

  Future<List<ItemHistoricoModel>> recuperarItensHistoricos() async {
    db = await Banco.instancia.database;

    _itensHistoricos.clear();
    notifyListeners();

    final List<Map<String, dynamic>> itensHistoricosMap = await db.rawQuery(
      itemHistoricoTableName,
    );

    for (int i = 0; i < itensHistoricosMap.length; i++) {
      _itensHistoricos.add(ItemHistoricoModel.fromMap(itensHistoricosMap[i]));
    }

    debugPrint("💁🏻🐉RPIH recuperarItensHistoricos() _itensHistoricos: ${_itensHistoricos.length}");
        notifyListeners();

    return _itensHistoricos;
  }

  Future<void> criarItemHistorico(ItemHistoricoModel itemHistorico) async {
    db = await Banco.instancia.database;

    final id = await db.insert(
      itemHistoricoTableName,
      itemHistorico.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    itemHistorico.id = id;

     debugPrint("💁🏻🐉RPIH  criarItemHistorico() id: $id");

    _itensHistoricos.add(itemHistorico);
    notifyListeners();
  }


  Future<void> excluirItemHistorico(ItemHistoricoModel itemHistorico) async {
    db = await Banco.instancia.database;

    await db.delete(itemHistoricoTableName,
        where: '$itemHistoricoColumnItemId = ?', whereArgs: [itemHistorico.id]);

     debugPrint("💁🏻🐉RPIH  excluirItemHistorico() id: ${itemHistorico.id}");

    _itensHistoricos.remove(itemHistorico);
    notifyListeners();
  }


  Future<void> editarItemHistorico(ItemHistoricoModel itemHistorico) async {
    db = await Banco.instancia.database;

    await db.update(itemHistoricoTableName, itemHistorico.toMap(),
        where: '$itemHistoricoColumnItemId = ?', whereArgs: [itemHistorico.id]);

    for (int i = 0; i < _itensHistoricos.length; i++) {
      if (_itensHistoricos[i].id == itemHistorico.id) {
        _itensHistoricos[i] = itemHistorico;
        break;
      }
    }

    debugPrint("💁🏻🐉RPIH  editarItemHistorico() id: ${itemHistorico.id}");
    notifyListeners();
  }
  
}