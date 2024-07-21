import 'const_tb_categorias.dart';

const String itemPadraoTableName = 'tb_item_padrao';


const String itemPadraoColumnId = 'id_item_padrao';
const String itemPadraoColumnCategoriaId = 'id_categoria_';
const String itemPadraoColumnNome = 'nome_item_padrao';


const String createItemPadraoTable = '''
  CREATE TABLE $itemPadraoTableName (
    $itemPadraoColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $itemPadraoColumnCategoriaId INTEGER NOT NULL,
    $itemPadraoColumnNome TEXT NOT NULL,
    FOREIGN KEY ($itemPadraoColumnCategoriaId) REFERENCES $categoriaTableName($categoriaColumnId)
  )
  ''';