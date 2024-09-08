import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../constants/const_tb_item_historico.dart';
import '../database/banco.dart';
import '../models/item_historico.module.dart';

class ItensHistoricoRepository extends ChangeNotifier {
   final List<ItemHistoricoModel> _itensHistoricos = [];
  List<ItemHistoricoModel> get getItensHistoricos => _itensHistoricos;

  late Database db;

 recuperarItensHistoricos(int idHistorico) async {
   debugPrint("💁🏻🐉RPIH recuperarItensHistoricos() entrou");
    db = await Banco.instancia.database;

    _itensHistoricos.clear();
    //notifyListeners();

    final List<Map<String, dynamic>> itensHistoricosMap = await db.query(
      itemHistoricoTableName,
      where: "$itemHistoricoColumnHistoricoId = ?",
      whereArgs: [idHistorico],
    );
    debugPrint("💁🏻🐉RPIH recuperarItensHistoricos() antes do for: $itensHistoricosMap");
    debugPrint("💁🏻🐉RPIH recuperarItensHistoricos() antes do for: ${_itensHistoricos.length}");
 
    for (int i = 0; i < itensHistoricosMap.length; i++) {
      
      _itensHistoricos.add(ItemHistoricoModel.fromMap(itensHistoricosMap[i]));
      //debugPrint("💁🏻🐉RPIH recuperarItensHistoricos() dentro do for: ${_itensHistoricos[i]}");
    }

    debugPrint("💁🏻🐉RPIH recuperarItensHistoricos() dps do for: ${_itensHistoricos.length}");
        notifyListeners();

    return _itensHistoricos;
  }

  Future<void> salvarItemHistorico(List<ItemHistoricoModel> itemHistorico) async {
    db = await Banco.instancia.database;

    for (int i = 0; i < itemHistorico.length; i++) {
      await db.insert(
        itemHistoricoTableName,
        itemHistorico[i].toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    debugPrint("💁🏻🐉RPIH salvarItemHistorico() itemHistorico: ${itemHistorico.length}");
    
    notifyListeners();
  }


  Future<void> excluirItemHistorico(int idHistorico) async {
    db = await Banco.instancia.database;

    await db.delete(itemHistoricoTableName,
        where: '$itemHistoricoColumnHistoricoId = ?', whereArgs: [idHistorico]);

     debugPrint("💁🏻🐉RPIH  excluirItemHistorico() idHisotrico: $idHistorico");

    
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