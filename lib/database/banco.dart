import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/const_tb_item.dart';
import '../constants/const_tb_lista.dart';



class Banco {
  // construtor com acesso privado
  Banco._();

  // instancia do Banco
  static final Banco instancia = Banco._();

  //Instancia do SQLite
  static Database? _database;

  get database async {
    
    if (_database != null) {
      return _database;
    }
    return await _initDatabase();
  }

  _initDatabase() async {
   
    return await openDatabase(
      join(await getDatabasesPath(), 'banco.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    // Execute a instrução CREATE TABLE no banco de dados.
    await db.execute(createListaTable);
    await db.execute(createItemTable);
  }
}
