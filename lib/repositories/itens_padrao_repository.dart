import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../constants/const_tb_categorias.dart';
import '../constants/const_tb_item_padrao.dart';
import '../database/banco.dart';
import '../models/item_padrao.module.dart';

class ItensPadraoRepository extends ChangeNotifier {
  final List<ItemPadraoModel> _itensPadrao = [];
  List<ItemPadraoModel> get getItensPadrao => _itensPadrao;

  late Database db;

  ItensPadraoRepository() {
    if (_itensPadrao.isEmpty) {
      recuperarItensPadrao();
    }
  }
  Future<List<ItemPadraoModel>> recuperarItensPadrao() async {
    _itensPadrao.clear();
    notifyListeners();

    db = await Banco.instancia.database;
    final List<Map<String, dynamic>> itensPadraoMap = await db.rawQuery('''
    SELECT i.*, c.$categoriaColumnName
    FROM $itemPadraoTableName i
    INNER JOIN $categoriaTableName c ON i.$itemPadraoColumnCategoriaId = c.$categoriaColumnId
  ''');
    for (int i = 0; i < itensPadraoMap.length; i++) {
      _itensPadrao.add(ItemPadraoModel.fromMap(itensPadraoMap[i]));
    }

    notifyListeners();

    debugPrint("💁🏻🥇RPI recuperarItensPadrao(): ${_itensPadrao.length}");
    return _itensPadrao;
  }

  Future<void> criarItemPadrao(ItemPadraoModel itemPadrao) async {
    db = await Banco.instancia.database;

    final id = await db.insert(
      itemPadraoTableName,
      itemPadrao.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    itemPadrao.idItemPadrao = id;
    _itensPadrao.add(itemPadrao);

    debugPrint("💁🏻🥇RPI criarItemPadrao() id: $id");

    notifyListeners();
  }

  Future<void> excluirItemPadrao(ItemPadraoModel itemPadrao) async {
    db = await Banco.instancia.database;

    await db.delete(
      itemPadraoTableName,
      where: '$itemPadraoColumnId = ?',
      whereArgs: [itemPadrao.idItemPadrao],
    );

    _itensPadrao.remove(itemPadrao);
    debugPrint("💁🏻🥇RPI excluirItemPadrao() id: ${itemPadrao.idItemPadrao}");

    notifyListeners();
  }

  editarItemPadrao(ItemPadraoModel itemPadrao) async {
    db = await Banco.instancia.database;

    await db.update(
      itemPadraoTableName,
      itemPadrao.toMap(),
      where: '$itemPadraoColumnId = ?',
      whereArgs: [itemPadrao.idItemPadrao],
    );

    for (int i = 0; i < _itensPadrao.length; i++) {
      if (_itensPadrao[i].idItemPadrao == itemPadrao.idItemPadrao) {
        _itensPadrao[i] = itemPadrao;
        break;
      }
    }

    debugPrint("💁🏻🥇RPI editarItemPadrao() id: ${itemPadrao.idItemPadrao}");

    notifyListeners();
  }
}
