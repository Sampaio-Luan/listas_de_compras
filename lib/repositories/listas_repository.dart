import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../constants/const_tb_lista.dart';
import '../database/banco.dart';
import '../models/lista.module.dart';

class ListasRepository extends ChangeNotifier {
  final List<ListaModel> listas = [];
  List<ListaModel> get getListas => listas;

  late Database db;

  ListasRepository() {
    _initRepository();
  }

  _initRepository() async {
    await recuperarListas();
  }

  recuperarListas() async {
    db = await Banco.instancia.database;
    listas.clear();
    final List<Map<String, dynamic>> listasMap = await db.query(
      listaTableName,
    );
    for (int i = 0; i < listasMap.length; i++) {
      listas.add(ListaModel.fromMap(listasMap[i]));

      debugPrint("get Lista:    ${listas[i]}");
    }

    notifyListeners();
    return listas;
  }

  inserirLista(ListaModel lista) async {
    db = await Banco.instancia.database;
    final id = await db.insert(
      listaTableName,
      lista.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint("Vai tomar:    $id");
    recuperarListas();
  }

  atualizarLista(ListaModel lista) async {
    db = await Banco.instancia.database;
    await db.update(
      listaTableName,
      lista.toMap(),
      where: '$listaColumnId = ?',
      whereArgs: [lista.id],
    );

    recuperarListas();
  }

  excluirLista(ListaModel lista) async {
    db = await Banco.instancia.database;
    await db.delete(
      listaTableName,
      where: '$listaColumnId = ?',
      whereArgs: [lista.id],
    );

    recuperarListas();
  }
}
