import '../constants/const_tb_historico.dart';

class HistoricoModel {
  int id;
  String data;
  String titulo;
  String descricao;
  double total;

  HistoricoModel(
      {required this.id,
      required this.data,
      required this.titulo,
      required this.descricao,
      required this.total});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({historicoColumnData: data});
    result.addAll({historicoColumnTitulo: titulo});
    result.addAll({historicoColumnDescricao: descricao});
    return result;
  }

  factory HistoricoModel.fromMap(Map<String, dynamic> map) {
    return HistoricoModel(
      id: map[historicoColumnId] ?? 0,
      data: map[historicoColumnData] ?? '',
      titulo: map[historicoColumnTitulo] ?? '',
      descricao: map[historicoColumnDescricao] ?? '',
      total: map['total'] ?? 0.0,
    );
  }
}
