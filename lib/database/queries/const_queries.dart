import '../../constants/const_tb_item.dart';
import '../../constants/const_tb_lista.dart';


//#region ==== RECUPERAR LISTAS COM TOTAL DE ITENS =========================

const String kListasComTotalItens = '''        
        SELECT
            l.$listaColumnId,
            l.$listaColumnName ,
            COUNT(i.$itemColumnId) AS total_itens,
            SUM(i.$itemColumnComprado) AS itens_comprados,
            l.$listaColumnCriacao 
        FROM
            $listaTableName l
        LEFT JOIN
            $itemTableName i ON l.$listaColumnId = i.$itemColumnListaId
        GROUP BY
            l.$listaColumnId, l.$listaColumnName, l.$listaColumnCriacao;
''';

//#endregion ===============================================================
