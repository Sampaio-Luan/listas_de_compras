import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../constants/const_tb_categorias.dart';
import '../database/banco.dart';
import '../models/categoria.module.dart';

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

  Future<void> excluirCategorias(CategoriaModel categoria) async {
    db = await Banco.instancia.database;

    await db.delete(categoriaTableName,
        where: '$categoriaColumnId = ?', whereArgs: [categoria.id]);

    debugPrint("💁🏻🥈RPC excluirCategorias() id: ${categoria.id}");

    _categorias.remove(categoria);
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
