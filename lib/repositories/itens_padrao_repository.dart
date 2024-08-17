import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../constants/const_tb_categorias.dart';
import '../constants/const_tb_item.dart';
import '../constants/const_tb_item_padrao.dart';
import '../database/banco.dart';
import '../models/item_padrao.module.dart';

class ItensPadraoRepository extends ChangeNotifier {
  final List<ItemPadraoModel> _itensPadrao = [];
  final List<ItemPadraoModel> _itensPadraoInterface = [];
  List<ItemPadraoModel> get getItensPadrao => _itensPadrao;
  List<ItemPadraoModel> get getItensPadraoInterface => _itensPadraoInterface;

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

    _itensPadraoInterface.addAll(_itensPadrao);

    notifyListeners();

    debugPrint("🐉🦆RPIP recuperarItensPadrao(): ${_itensPadrao.length}");
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

    debugPrint("🐉🦆RPIP criarItemPadrao() id: $id");

    notifyListeners();
  }

  Future<void> excluirItemPadrao(ItemPadraoModel itemPadrao) async {
    db = await Banco.instancia.database;

    await db.delete(
      itemPadraoTableName,
      where: '$itemPadraoColumnId = ?',
      whereArgs: [itemPadrao.idItemPadrao],
    );

    _itensPadraoInterface.remove(itemPadrao);
    _itensPadrao.clear();
    notifyListeners();
    _itensPadrao.addAll(_itensPadraoInterface);
    debugPrint("🐉🦆RPIP excluirItemPadrao() id: ${itemPadrao.idItemPadrao}");

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

    debugPrint("🐉🦆RPIP editarItemPadrao() id: ${itemPadrao.idItemPadrao}");

    notifyListeners();
  }

  filtrarItemPadrao(int idCategoria) async {
    _itensPadraoInterface.clear();
    notifyListeners();
    debugPrint('🐉🦆RPIP id categoria $idCategoria');

    if (idCategoria == 0) {
      _itensPadraoInterface.addAll(_itensPadrao);
    } else {
      for (int i = 0; i < _itensPadrao.length; i++) {
        if (_itensPadrao[i].idCategoria == idCategoria) {
          _itensPadraoInterface.add(_itensPadrao[i]);
        }
      }
    }

    debugPrint("🐉🦆RPIP filtrarItemPadrao(): ${_itensPadraoInterface.length}");

    notifyListeners();
  }

  int val = 8;
  corrijarJ() async {
    for (int i = 9; i > 0; i--) {
      db = await Banco.instancia.database;

      await db.update(
        itemPadraoTableName,
        {itemPadraoColumnCategoriaId: i},
        where: '$itemPadraoColumnCategoriaId = ?',
        whereArgs: [val],
      );

      await db.update(
        itemTableName,
        {itemColumnCategoriaId: i},
        where: '$itemColumnCategoriaId = ?',
        whereArgs: [val],
      );
    debugPrint('🐉🦆RPIP corrigirJ() val:$val i: $i');
      val--;
    }
    
  }
  
}
