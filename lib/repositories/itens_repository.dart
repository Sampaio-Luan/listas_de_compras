import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import 'package:listas_de_compras/models/item.module.dart';

import '../constants/const_tb_item.dart';
import '../database/banco.dart';

class ItensRepository extends ChangeNotifier {
  final List<ItemModel> _itens = [];
  final List<ItemModel> _itensFiltrados = [];
  final List<ItemModel> _itensOrdenados = [];
  List<ItemModel> get itens => _itens;
  List<ItemModel> get itensFiltrados => _itensFiltrados;
  List<ItemModel> get itensOrdenados => _itensOrdenados;

  final Map<int, List<ItemModel>> _itensPorLista = {};
  Map<int, List<ItemModel>> get itensPorLista => _itensPorLista;

  late Database db;

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
      _itens.add(ItemModel.fromMap(itensMap[i]));
      
      debugPrint("${itensMap[i]}");
    }

    // _organizarItemPorLista();

    return _itens;
  }

  // _organizarItemPorLista() {
  //   _itensPorLista.clear();
  //   for (var item in _itens) {
  //     if (_itensPorLista.containsKey(item.idLista)) {
  //       _itensPorLista[item.idLista]!.add(item);
  //     } else {
  //       _itensPorLista[item.idLista] = [item];
  //     }
  //   }
  // }

  recuperarItensFiltrado(String filtro) async {
    db = await Banco.instancia.database;

    int isComprado = filtro == 'Comprado' ? 1 : 0;

    final List<Map<String, dynamic>> itensMap = await db.query(
      itemTableName,
      where: "$itemColumnName = ?",
      whereArgs: [isComprado],
    );

    for (int i = 0; i < itensMap.length; i++) {
      _itensFiltrados.add(ItemModel.fromMap(itensMap[i]));
    }
    notifyListeners();
    return _itensFiltrados;
  }

  recuperarItensOrdenado(String ordem) async {
    db = await Banco.instancia.database;

    final List<Map<String, dynamic>> itensMap = await db.query(
      itemTableName,
      orderBy: "$itemColumnName ASC",
    );
    for (int i = 0; i < itensMap.length; i++) {
      _itensOrdenados.add(ItemModel.fromMap(itensMap[i]));
    }
    notifyListeners();
    return _itensOrdenados;
  }

  inserirItem(ItemModel item) async {
    db = await Banco.instancia.database;
    final id = await db.insert(
      itemTableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint("Vai tomar:    $id");
    return await recuperarItens(item.idLista);
  }

  atualizarItem(ItemModel item) async {
    db = await Banco.instancia.database;
    await db.update(
      itemTableName,
      item.toMap(),
      where: "$itemColumnId = ?",
      whereArgs: [item.idItem],
    );
    return await recuperarItens(item.idLista);
  }

  excluirItem(ItemModel item) async {
    db = await Banco.instancia.database;
    await db.delete(
      itemTableName,
      where: "$itemColumnId = ?",
      whereArgs: [item.idItem],
    );
    return await recuperarItens(item.idLista);
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
    return await recuperarItens(item.idLista);
  }
}
