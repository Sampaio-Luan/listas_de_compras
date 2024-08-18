
import 'const_tb_historico.dart';

const String itemHistoricoTableName = 'tb_item_historico';


const String itemHistoricoColumnItemId = 'id_item';
const String itemHistoricoColumnHistoricoId = 'id_historico';
const String itemHistoricoColumnNome = 'nome_historico_item';
const String itemHistoricoColumnQuantidade = 'quantidade_historico_item';
const String itemHistoricoColumnMedida = 'medida_historico_item';
const String itemHistoricoColumnPreco = 'preco_historico_item';
const String itemHistoricoColumnTotal = 'total_historico_item';
const String itemHistoricoColumnCategoria = 'categoria_historico_item';


const String createItemHistoricoTable = '''
  CREATE TABLE $itemHistoricoTableName (
    $itemHistoricoColumnItemId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $itemHistoricoColumnHistoricoId INTEGER NOT NULL,
    $itemHistoricoColumnNome TEXT NOT NULL,
    $itemHistoricoColumnQuantidade REAL NOT NULL,
    $itemHistoricoColumnMedida TEXT NOT NULL,
    $itemHistoricoColumnPreco REAL NOT NULL,
    $itemHistoricoColumnTotal REAL NOT NULL,
    $itemHistoricoColumnCategoria INTEGER NOT NULL,
    FOREIGN KEY ($itemHistoricoColumnHistoricoId) REFERENCES $historicoTableName($historicoColumnId)
  )''';