
// #region -- TABELA DE LISTAS --
const String listaTableName = 'tb_listas';
const String listaColumnId = 'id_lista';
const String listaColumnName = 'nome_lista';
const String listaColumnDescricao = 'descricao_lista';
const String listaColumnCriacao = 'criacao';
const String listaColumnIndice = 'indice';
const String listaColumnIcone = 'icone';



const String createListaTable = '''
  CREATE TABLE $listaTableName (
    $listaColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $listaColumnName TEXT NOT NULL,
    $listaColumnDescricao TEXT NOT NULL,
    $listaColumnCriacao TEXT NOT NULL,
    $listaColumnIndice INTEGER,
    $listaColumnIcone TEXT
  )
  ''';
// #endregion


// #region -- TABELA DE ITENS --
const String itemTableName = 'tb_itens';
const String itemColumnId = 'id_item';
const String itemColumnName = 'nome_item';
const String itemColumnDescricao = 'descricao_item';
const String itemColumnListaId = 'id_lista';
const String itemColumnPreco = 'preco_item';
const String itemColumnQuantidade = 'quantidade_item';
const String itemColumnComprado = 'comprado_item';
const String itemColumnIndice = 'indice_item';

const String createItemTable = '''
    CREATE TABLE $itemTableName (
      $itemColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $itemColumnName TEXT NOT NULL,
      $itemColumnDescricao TEXT NOT NULL,
      $itemColumnListaId INTEGER NOT NULL,
      $itemColumnPreco REAL NOT NULL,
      $itemColumnQuantidade INTEGER NOT NULL,
      $itemColumnComprado INTEGER NOT NULL,
      $itemColumnIndice INTEGER,
      FOREIGN KEY ($itemColumnListaId) REFERENCES $listaTableName($listaColumnId)
    )
  ''';
// #endregion
