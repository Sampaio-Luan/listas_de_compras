import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/const_tb_categorias.dart';
import '../constants/const_tb_historico.dart';
import '../constants/const_tb_item.dart';
import '../constants/const_tb_item_historico.dart';
import '../constants/const_tb_item_padrao.dart';
import '../constants/const_tb_lista.dart';

class Banco {
  // construtor com acesso privado
  Banco._();

  // instancia do Banco
  static final Banco instancia = Banco._();

  //Instancia do SQLite
  static Database? _database;

  get database async {
    // await deleteDatabase(
    //   join(await getDatabasesPath(), 'banco.db'),
    // );
    // debugPrint('Banco deletado !!!');

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
    await db.execute(createCategoriaTable);
    await db.execute(createHistoricoTable);
    await db.execute(createItemHistoricoTable);
    await db.execute(createItemPadraoTable);

    debugPrint('Banco criado com sucesso !!!');

    for (final categoria in categorias) {
      await db.insert(categoriaTableName, categoria);
    }
    debugPrint('Categorias criadas com sucesso !!!');

    for (final item in itensPadrao) {
      await db.insert(itemPadraoTableName, {
        itemPadraoColumnNome: item.keys.first,
        itemPadraoColumnCategoriaId: item.values.first
      });
    }

    debugPrint('Itens Padrao criados com sucesso !!!');
  }

  List<Map<String, dynamic>> categorias = [
    {categoriaColumnName: 'Açougue', categoriaColumnGrau: 0},
    {categoriaColumnName: 'Básicos', categoriaColumnGrau: 1},
    {categoriaColumnName: 'Bebidas', categoriaColumnGrau: 2},
    {categoriaColumnName: 'Congelados', categoriaColumnGrau: 3},
    {categoriaColumnName: 'Feira', categoriaColumnGrau: 4},
    {categoriaColumnName: 'Frios', categoriaColumnGrau: 5},
    {categoriaColumnName: 'Higiene', categoriaColumnGrau: 6},
    {categoriaColumnName: 'Limpeza', categoriaColumnGrau: 7},
    {categoriaColumnName: 'Sem Categoria', categoriaColumnGrau: 8},
  ];

  final List<Map<String, int>> itensPadrao = [
//AÇOUGUE
    {'Carne moída': 1},
    {'Carne do sol': 1},
    {'Picanha': 1},
    {'Alcatra': 1},
    {'Coxão duro': 1},
    {'Coxão mole': 1},
    {'Cupim': 1},
    {'Costela': 1},
    {'Fígado': 1},
    {'Linguiça toscana': 1},
    {'Salsicha': 1},
    {'Coxinha da asa de frango': 1},
    {'Filé de frango': 1},
//BASICOS
    {'Arroz': 2},
    {'Feijão': 2},
    {'Macarrão': 2},
    {'Grão-de-bico': 2},
    {'Lentilha': 2},
    {'Açúcar': 2},
    {'Sal': 2},
    {'Óleo': 2},
    {'Azeite': 2},
    {'Temperos prontos': 2},
    {'Maionese': 2},
    {'Extrato de tomate': 2},
    {'Molho de tomate': 2},
    {'Fermento': 2},
    {'Massa para bolo': 2},
    {'Farinha de trigo': 2},
    {'Farofa': 2},
    {'Café': 2},
    {'Chá': 2},
    {'Bolacha': 2},
    {'Biscoito': 2},

//BEBIDAS
    {'Água': 3},
    {'Leite': 3},
    {'Sucos': 3},
    {'Água de coco': 3},
    {'Refrigerante': 3},
    {'Cerveja': 3},
    {'Vinho': 3},
    {'Chá pronto': 3},
    {'Achocolatado': 3},
    {'Vodka': 3},
    {'Whiskey': 3},
    {'Cachaça': 3},
//CONGELADOS
    {'Frango': 4},
    {'Carne vermelha': 4},
    {'Peixe': 4},
    {'Lasanha': 4},
    {'Pizza': 4},
    {'Salsicha': 4},
    {'Hambúrguer': 4},
    {'Linguiça': 4},
    {'Pão de queijo': 4},
    {'Batata palito': 4},
    {'Pratos prontos': 4},
    {'Vegetais': 4},
    {'Frutas': 4},
    {'Sorvetes': 4},
    {'Pão de alho': 4},
//FEIRA
    {'Alface': 5},
    {'Cebola': 5},
    {'Cenoura': 5},
    {'Batata': 5},
    {'Tomate': 5},
    {'Pimenta': 5},
    {'Cebolinha': 5},
    {'Pimenta-do-reino': 5},
    {'Cebola-roxa': 5},
    {'Banana': 5},
    {'Laranja': 5},
    {'Lima': 5},
    {'Abacaxi': 5},
    {'Macaxeira': 5},
    {'Manga': 5},
    {'Uva': 5},
    {'Morango': 5},
    {'Maracuja': 5},
    {'Coco': 5},
    {'Cereja': 5},
    {'Caju': 5},
    {'Framboesa': 5},
    {'Abacate': 5},
    {'Melão': 5},
    {'Abobrinha': 5},
    {'Pepino': 5},
    {'Nectarina': 5},
    {'Melancia': 5},
    {'Melão': 5},
    {'Maçã': 5},
//FRIOS
    {'Presunto': 6},
    {'Apresuntado': 6},
    {'Mortadela': 6},
    {'Peito de peru': 6},
    {'Salame': 6},
    {'Requeijão': 6},
    {'Manteiga': 6},
    {'Margarina': 6},
    {'Leite Fermentado': 6},
    {'Iogurtes': 6},
    {'Sobremesas lácteas': 6},
//HIGIENE PESSOAL
    {'Shampoo': 7},
    {'Condicionador': 7},
    {'Sabonete': 7},
    {'Creme': 7},
    {'Escova de dentes': 7},
    {'Pomada': 7},
    {'Desodorante': 7},
    {'Papel higiênico': 7},
    {'Algodão': 7},
    {'Creme dental': 7},
    {'Creme hidratante': 7},
    {'Cotonete': 7},
    {'Esponja de banho': 7},
//LIMPEZA
    {'Água sanitária': 8},
    {'Desinfetante': 8},
    {'Detergente': 8},
    {'Esponja de aço': 8},
    {'Sabão em pó': 8},
    {'Amaciante': 8},
    {'Sabão em pedra': 8},
    {'Alvejante': 8},
    {'Vassoura': 8},
    {'Pá de lixo': 8},
    {'Rodo': 8},
    {'Pano de chão': 8},
    {'Pano de prato': 8},
    {'Luva de borracha': 8},
    {'Pedra sanitária': 8},
    {'Sacos de lixo': 8},
  ];
}
