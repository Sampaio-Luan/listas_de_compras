import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/const_tb_historico.dart';
import '../database/banco.dart';
import '../models/historico.module.dart';

class HistoricoRepository extends ChangeNotifier {
  final List<HistoricoModel> _historicos = [];
  List<HistoricoModel> get getHistoricos => _historicos;

  late Database db;

  Future<List<HistoricoModel>> recuperarHistoricos() async {
    db = await Banco.instancia.database;

    _historicos.clear();
    notifyListeners();

    final List<Map<String, dynamic>> historicosMap =
        await db.rawQuery(historicoTableName);

    for (int i = 0; i < historicosMap.length; i++) {
      _historicos.add(HistoricoModel.fromMap(historicosMap[i]));
    }

    debugPrint("💁🏻⏳RPH recuperarHistoricos(): ${_historicos.length}");
    notifyListeners();
    return _historicos;
  }

  Future<void> criarHistorico(HistoricoModel historico) async {
    db = await Banco.instancia.database;

    final id = await db.insert(
      historicoTableName,
      historico.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    historico.id = id;

    debugPrint("💁🏻⏳RPH criarHistorico() id: $id");

    _historicos.add(historico);
    notifyListeners();
  }

  Future<void> excluirHistorico(HistoricoModel historico) async {
    db = await Banco.instancia.database;

    await db.delete(historicoTableName,
        where: '$historicoColumnId = ?', whereArgs: [historico.id]);

    debugPrint("💁🏻⏳RPH excluirHistorico() id: ${historico.id}");

    _historicos.remove(historico);
    notifyListeners();
  }

  editarHistorico(HistoricoModel historico) async {
    db = await Banco.instancia.database;

    await db.update(historicoTableName, historico.toMap(),
        where: '$historicoColumnId = ?', whereArgs: [historico.id]);

    for (int i = 0; i < _historicos.length; i++) {
      if (_historicos[i].id == historico.id) {
        _historicos[i] = historico;
        break;
      }
    }

    debugPrint("💁🏻⏳RPH editarHistorico() id: ${historico.id}");

    notifyListeners();
  }
}
