import 'const_tb_lista.dart';

const String itemTableName = 'tb_itens';

const String itemColumnId = 'id_item';
const String itemColumnListaId = 'id_lista';
const String itemColumnName = 'nome_item';
const String itemColumnDescricao = 'descricao_item';
const String itemColumnPreco = 'preco_item';
const String itemColumnQuantidade = 'quantidade_item';
const String itemColumnMedida = 'medida_item';
const String itemColumnComprado = 'comprado_item';
const String itemColumnIndice = 'indice_item';




const String createItemTable = '''
    CREATE TABLE $itemTableName (
      $itemColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $itemColumnName TEXT NOT NULL,
      $itemColumnDescricao TEXT NOT NULL,
      $itemColumnListaId INTEGER NOT NULL,
      $itemColumnPreco REAL NOT NULL,
      $itemColumnQuantidade REAL NOT NULL,
      $itemColumnMedida TEXT NOT NULL,
      $itemColumnComprado INTEGER NOT NULL,
      $itemColumnIndice INTEGER,
      FOREIGN KEY ($itemColumnListaId) REFERENCES $listaTableName($listaColumnId)
    )
  ''';
