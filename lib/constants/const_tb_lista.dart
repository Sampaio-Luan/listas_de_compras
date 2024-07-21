const String listaTableName = 'tb_listas';

const String listaColumnId = 'id_lista';
const String listaColumnName = 'nome_lista';
const String listaColumnCriacao = 'criacao_lista';
const String listaColumnIndice = 'indice_lista';
const String listaColumnTema = 'tema_lista';



const String createListaTable = '''
  CREATE TABLE $listaTableName (
    $listaColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $listaColumnName TEXT NOT NULL,    
    $listaColumnCriacao TEXT NOT NULL,
    $listaColumnIndice INTEGER,    
    $listaColumnTema TEXT
  )
  ''';