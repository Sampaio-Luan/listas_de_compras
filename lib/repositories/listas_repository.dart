import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import 'package:listas_de_compras/constants/db_constants.dart';
import 'package:listas_de_compras/models/lista.module.dart';

import '../database/banco.dart';

class ListasRepository extends ChangeNotifier {
  final List<ListaModel> listas = [];
  List<ListaModel> get getListas => listas;

  late Database db;

  ListasRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _recuperarListas();
  }

  _recuperarListas() async {
    db = await Banco.instancia.database;
    listas.clear();
    final List<Map<String, dynamic>> listasMap = await db.query(
      listaTableName,
    );
    for (int i = 0; i < listasMap.length; i++) {
      listas.add(ListaModel(
          id: listasMap[i]['id_lista'],
          nome: listasMap[i]['nome_lista'],
          descricao: listasMap[i]['descricao_lista'],
          criacao: listasMap[i]['criacao'],
          indice: listasMap[i]['indice'],
          icone: listasMap[i]['icone']));

      debugPrint("get Lista:    ${listas[i]}");
    }

    notifyListeners();
  }

  inserirLista(ListaModel lista) async {
    db = await Banco.instancia.database;
    final id = await db.insert(
      listaTableName,
      lista.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint("Vai tomar:    $id");
    _recuperarListas();
  }

  atualizarLista(ListaModel lista) async {
    db = await Banco.instancia.database;
    await db.update(
      listaTableName,
      lista.toMap(),
      where: '$listaColumnId = ?',
      whereArgs: [lista.id],
    );

    _recuperarListas();
  }

  excluirLista(ListaModel lista) async {
    db = await Banco.instancia.database;
    await db.delete(
      listaTableName,
      where: '$listaColumnId = ?',
      whereArgs: [lista.id],
    );

    _recuperarListas();
  }
}
