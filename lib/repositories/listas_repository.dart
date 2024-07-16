import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../constants/const_tb_lista.dart';
import '../database/banco.dart';
import '../models/lista.module.dart';

class ListasRepository extends ChangeNotifier {
  final List<ListaModel> _listas = [];
  List<ListaModel> get getListas => _listas;

  late Database db;

  recuperarListas() async {
    db = await Banco.instancia.database;
    _listas.clear();
    final List<Map<String, dynamic>> listasMap = await db.query(
      listaTableName,
    );
    for (int i = 0; i < listasMap.length; i++) {
      _listas.add(ListaModel.fromMap(listasMap[i]));
    }
    debugPrint("💁🏻📝RPL recuperarLista(): ${_listas.length}");

    return _listas;
  }

  inserirLista(ListaModel lista) async {
    db = await Banco.instancia.database;
    final id = await db.insert(
      listaTableName,
      lista.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint("💁🏻📝RPL inserirLista() id: $id");
    return id;
  }

  atualizarLista(ListaModel lista) async {
    db = await Banco.instancia.database;
    await db.update(
      listaTableName,
      lista.toMap(),
      where: '$listaColumnId = ?',
      whereArgs: [lista.id],
    );

    debugPrint("💁🏻📝RPL atualizarLista() id: ${lista.nome}");

    recuperarListas();
  }

  excluirLista(ListaModel lista) async {
    db = await Banco.instancia.database;
    await db.delete(
      listaTableName,
      where: '$listaColumnId = ?',
      whereArgs: [lista.id],
    );

    debugPrint("💁🏻📝RPL excluirLista() id: ${lista.id}");

    recuperarListas();
  }
}
