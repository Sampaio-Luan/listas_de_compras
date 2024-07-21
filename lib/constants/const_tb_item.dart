import 'const_tb_categorias.dart';
import 'const_tb_lista.dart';

const String itemTableName = 'tb_itens';

const String itemColumnId = 'id_item';
const String itemColumnListaId = 'id_lista';
const String itemColumnCategoriaId = 'id_categoria_item';
const String itemColumnName = 'nome_item';
const String itemColumnDescricao = 'descricao_item';
const String itemColumnPreco = 'preco_item';
const String itemColumnQuantidade = 'quantidade_item';
const String itemColumnMedida = 'medida_item';
const String itemColumnComprado = 'comprado_item';
const String itemColumnIndice = 'indice_item';
const String itemColumnPrioridade = 'prioridade_item';





const String createItemTable = '''
    CREATE TABLE $itemTableName (
      $itemColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $itemColumnListaId INTEGER NOT NULL,
      $itemColumnCategoriaId INTEGER NOT NULL,
      $itemColumnName TEXT NOT NULL,
      $itemColumnDescricao TEXT NOT NULL,      
      $itemColumnPreco REAL NOT NULL,
      $itemColumnQuantidade REAL NOT NULL,
      $itemColumnMedida TEXT NOT NULL,
      $itemColumnComprado INTEGER NOT NULL,
      $itemColumnIndice INTEGER,
      $itemColumnPrioridade INTEGER NOT NULL,

      FOREIGN KEY ($itemColumnListaId) REFERENCES $listaTableName($listaColumnId),
      FOREIGN KEY ($itemColumnCategoriaId) REFERENCES $categoriaTableName($categoriaColumnId)
    )
  ''';
