import 'const_tb_item_historico.dart';

const String historicoTableName = 'tb_historico';

const String historicoColumnId = 'id_historico';
const String historicoColumnData = 'data_historico';
const String historicoColumnTitulo = 'titulo_historico';
const String historicoColumnDescricao = 'descricao_historico';

const String createHistoricoTable = '''
  CREATE TABLE $historicoTableName (
    $historicoColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $historicoColumnData TEXT NOT NULL,
    $historicoColumnTitulo TEXT NOT NULL,
    $historicoColumnDescricao TEXT NOT NULL
  )
  ''';

const String kQueryHistorico = '''
SELECT
    h.*,
    SUM(ih.$itemHistoricoColumnPreco * ih.$itemHistoricoColumnQuantidade) AS total
FROM
    $historicoTableName AS h
JOIN
    $itemHistoricoTableName AS ih ON h.$historicoColumnId = ih.$itemHistoricoColumnHistoricoId
GROUP BY
    h.$historicoColumnId;



''';
