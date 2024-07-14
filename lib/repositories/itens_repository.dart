import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../constants/const_tb_item.dart';
import '../database/banco.dart';
import '../models/item.module.dart';

class ItensRepository extends ChangeNotifier {
  final List<ItemModel> _itens = [];
  List<ItemModel> get itens => _itens;

  late Database db;

  recuperarItens(int idLista) async {
    db = await Banco.instancia.database;

    _itens.clear();

    final List<Map<String, dynamic>> itensMap = await db.query(
      itemTableName,
      where: "$itemColumnListaId = ?",
      whereArgs: [idLista],
    );

    debugPrint("recuperar Itens repository tamanho: ${itensMap.length}");

    for (int i = 0; i < itensMap.length; i++) {
      _itens.add(ItemModel.fromMap(itensMap[i]));

      debugPrint("recuperar itens repository: ${itensMap[i]}");
    }

    return _itens;
  }

  recuperarItensFiltrado(String filtro, int idLista) async {
    db = await Banco.instancia.database;
    _itens.clear();
    debugPrint('recuperarItensFiltrado: $filtro');

    int isComprado = filtro == 'Comprado' ? 1 : 0;

    final List<Map<String, dynamic>> itensMap = await db.query(
      itemTableName,
      where: "$itemColumnComprado = ? AND $itemColumnListaId = ?",
      whereArgs: [isComprado, idLista],
    );

    debugPrint("filtrado repository tamanho: ${itensMap.length}");

    for (int i = 0; i < itensMap.length; i++) {
      _itens.add(ItemModel.fromMap(itensMap[i]));

      debugPrint("Filtrado itens repository: ${itensMap[i]}");
    }

    notifyListeners();
    //return _itens;
  }

  recuperarItensOrdenado(String ordem) async {
    db = await Banco.instancia.database;
    _itens.clear();
    final List<Map<String, dynamic>> itensMap = await db.query(
      itemTableName,
      orderBy: "$itemColumnName ASC",
    );

    debugPrint("recuperarItensOrdenado repository tamanho: ${itensMap.length}");
    for (int i = 0; i < itensMap.length; i++) {
      _itens.add(ItemModel.fromMap(itensMap[i]));
      debugPrint("recuperarItensOrdenado itens repository: ${itensMap[i]}");
    }

    
    notifyListeners();
    return _itens;
  }

  inserirItem(ItemModel item) async {
    db = await Banco.instancia.database;
    final id = await db.insert(
      itemTableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("Repositorio Inseriu: ${item.nome} - $id");
    
  }

  atualizarItem(ItemModel item) async {
    db = await Banco.instancia.database;
    await db.update(
      itemTableName,
      item.toMap(),
      where: "$itemColumnId = ?",
      whereArgs: [item.idItem],
    );
    debugPrint("Repositorio Atualizou: ${item.nome}");
  }

  excluirItem(ItemModel item) async {
    db = await Banco.instancia.database;
    await db.delete(
      itemTableName,
      where: "$itemColumnId = ?",
      whereArgs: [item.idItem],
    );
    debugPrint("Repositorio Excluiu: ${item.nome}");
  }

  editarUmAtributo(
      {required String campo,
      required dynamic valor,
      required ItemModel item}) async {
    db = await Banco.instancia.database;
    await db.update(
      itemTableName,
      {campo: valor},
      where: "$itemColumnId = ?",
      whereArgs: [item.idItem],
    );
    
  }

  marcarTodosItens({required int idLista}) async {
    db = await Banco.instancia.database;
    await db.update(
      itemTableName,
      {itemColumnComprado: 1},
      where: "$itemColumnListaId = ?",
      whereArgs: [idLista],
    );

    debugPrint('REPOSITORIO Marcado todos itens');
  }

    desmarcarTodosItens({required int idLista}) async {
    db = await Banco.instancia.database;
    await db.update(
      itemTableName,
      {itemColumnComprado: 0},
      where: "$itemColumnListaId = ?",
      whereArgs: [idLista],
    );

    debugPrint('REPOSITORIO desmarcado todos itens');
  }
}
