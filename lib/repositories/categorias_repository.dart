import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../constants/const_tb_categorias.dart';
import '../constants/const_tb_item.dart';
import '../constants/const_tb_item_padrao.dart';
import '../controllers/itens_controller.dart';
import '../database/banco.dart';
import '../models/categoria.module.dart';
import 'itens_padrao_repository.dart';

class CategoriasRepository extends ChangeNotifier {
  final List<CategoriaModel> _categorias = [];

  List<CategoriaModel> get getCategorias => _categorias;

  late Database db;

  CategoriasRepository() {
    if (_categorias.isEmpty) {
      recuperarCategorias();
    }
  }
  Future<List<CategoriaModel>> recuperarCategorias() async {
    db = await Banco.instancia.database;

    _categorias.clear();
    notifyListeners();

    final List<Map<String, dynamic>> categoriasMap =
        await db.query(categoriaTableName);

    for (int i = 0; i < categoriasMap.length; i++) {
      _categorias.add(CategoriaModel.fromMap(categoriasMap[i]));
    }

    debugPrint("💁🏻🥈RPC recuperarCategorias(): ${_categorias.length}");
    notifyListeners();
    return _categorias;
  }

  Future<void> criarCategorias(CategoriaModel categoria) async {
    db = await Banco.instancia.database;

    final id = await db.insert(
      categoriaTableName,
      categoria.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    categoria.id = id;

    debugPrint("💁🏻🥈RPC criarCategorias() id: $id");

    _categorias.add(categoria);
    notifyListeners();
  }

  Future<void> excluirCategorias(CategoriaModel categoria, ItensController itemC, ItensPadraoRepository itemPR) async {
    db = await Banco.instancia.database;

    await db.delete(categoriaTableName,
        where: '$categoriaColumnId = ?', whereArgs: [categoria.id]);

    debugPrint("💁🏻🥈RPC excluirCategorias() id: ${categoria.id}");

    _categorias.remove(categoria);
    await db.update(
      itemTableName,
      {itemColumnCategoriaId: 9},
      where: '$itemColumnCategoriaId  = ?',
      whereArgs: [categoria.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await db.update(
      itemPadraoTableName,
      {itemPadraoColumnId: 9},
      where: '$itemPadraoColumnId  = ?',
      whereArgs: [categoria.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await itemC.iniciarController(idLista: itemC.getIdLista,nomeLista: itemC.nomeLista);
    await itemPR.recuperarItensPadrao();
    
    notifyListeners();
  }

  editarCategorias(List<CategoriaModel> categoria) async {
    db = await Banco.instancia.database;

    for (int i = 0; i < categoria.length; i++) {
      await db.update(categoriaTableName, categoria[i].toMap(),
          where: '$categoriaColumnId = ?', whereArgs: [categoria[i].id]);
    }

    debugPrint("💁🏻🥈RPC editarCategorias()");

    for (int i = 0; i < _categorias.length; i++) {
      for (int j = 0; j < categoria.length; j++) {
        if (_categorias[i].id == categoria[j].id) {
          _categorias[i] = categoria[j];
          break;
        }
      }
    }

    notifyListeners();
  }
}
