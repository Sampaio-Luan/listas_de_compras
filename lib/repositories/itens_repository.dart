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

    for (int i = 0; i < itensMap.length; i++) {
      _itens.add(ItemModel.fromMap(itensMap[i]));
    }
    debugPrint('💁🏻‍♀️🧺RPi recuperarItens() _itens: ${_itens.length}');

    return _itens;
  }

  recuperarItensFiltrado(String filtro, int idLista) async {
    db = await Banco.instancia.database;
    _itens.clear();

    int isComprado = filtro == 'Comprado' ? 1 : 0;

    final List<Map<String, dynamic>> itensMap = await db.query(
      itemTableName,
      where: "$itemColumnComprado = ? AND $itemColumnListaId = ?",
      whereArgs: [isComprado, idLista],
    );

    for (int i = 0; i < itensMap.length; i++) {
      _itens.add(ItemModel.fromMap(itensMap[i]));
    }
    debugPrint(
        '💁🏻‍♀️🧺RPi recuperarItensFiltrados() filtro $filtro , itens: ${_itens.length}');

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

    for (int i = 0; i < itensMap.length; i++) {
      _itens.add(ItemModel.fromMap(itensMap[i]));
    }

    debugPrint(
        '💁🏻‍♀️🧺RPi recuperarItensOrdenado() itens: ${_itens.length}, ordem: $ordem');
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

    debugPrint('💁🏻‍♀️🧺RPi insrirItem, nome:${item.nome} - id: $id');
  }

  atualizarItem(ItemModel item) async {
    db = await Banco.instancia.database;
    await db.update(
      itemTableName,
      item.toMap(),
      where: "$itemColumnId = ?",
      whereArgs: [item.idItem],
    );
    debugPrint('💁🏻‍♀️🧺RPi atualizarItem(), item: ${item.nome}');
  }

  excluirItem(ItemModel item) async {
    db = await Banco.instancia.database;
    await db.delete(
      itemTableName,
      where: "$itemColumnId = ?",
      whereArgs: [item.idItem],
    );
    debugPrint('💁🏻‍♀️🧺RPi excluirItem(), item: ${item.nome}');
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

    debugPrint(
        '💁🏻‍♀️🧺RPi editarUmAtributo(), campo: $campo, valor: $valor, item: ${item.nome} e id: ${item.idItem} ');
        return true;
  }

  marcarTodosItens({required int idLista}) async {
    db = await Banco.instancia.database;
    await db.update(
      itemTableName,
      {itemColumnComprado: 1},
      where: "$itemColumnListaId = ?",
      whereArgs: [idLista],
    );

    debugPrint('💁🏻‍♀️🧺RPi marcarTodosItens()');
    
  }

  desmarcarTodosItens({required int idLista}) async {
    db = await Banco.instancia.database;
    await db.update(
      itemTableName,
      {itemColumnComprado: 0},
      where: "$itemColumnListaId = ?",
      whereArgs: [idLista],
    );

    debugPrint('💁🏻‍♀️🧺RPi desmarcarTodosItens()');
  }


}
