const String categoriaTableName = 'tb_categoria';


const String categoriaColumnId = 'id_categoria';
const String categoriaColumnName = 'nome_categoria';
const String categoriaColumnGrau = 'grau_categoria';


const String createCategoriaTable = '''
  CREATE TABLE $categoriaTableName (
    $categoriaColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $categoriaColumnName TEXT NOT NULL,
    $categoriaColumnGrau INTEGER NOT NULL
  )
  ''';