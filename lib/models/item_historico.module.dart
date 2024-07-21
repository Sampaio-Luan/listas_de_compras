import '../constants/const_tb_item_historico.dart';

class ItemHistoricoModel {

  int id;
  int idHistorico;
  String nome;
  double quantidade;
  String medida;
  double preco;
  double total;
  String categoria;

  ItemHistoricoModel({
    required this.id,
    required this.idHistorico,
    required this.nome,
    required this.quantidade,
    required this.medida,
    required this.preco,
    required this.total,
    required this.categoria,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    
    result.addAll({itemHistoricoColumnItemId: id});
    result.addAll({itemHistoricoColumnHistoricoId: idHistorico});
    result.addAll({itemHistoricoColumnNome: nome});
    result.addAll({itemHistoricoColumnQuantidade: quantidade});
    result.addAll({itemHistoricoColumnMedida: medida});
    result.addAll({itemHistoricoColumnPreco: preco});
    result.addAll({itemHistoricoColumnTotal: total});
    result.addAll({itemHistoricoColumnCategoria: categoria});
    return result;
  }

  factory ItemHistoricoModel.fromMap(Map<String, dynamic> map) {
    return ItemHistoricoModel(
      id: map[itemHistoricoColumnItemId] ?? 0,
      idHistorico: map[itemHistoricoColumnHistoricoId] ?? 0,
      nome: map[itemHistoricoColumnNome] ?? '',
      quantidade: map[itemHistoricoColumnQuantidade] ?? 0.0,
      medida: map[itemHistoricoColumnMedida] ?? '',
      preco: map[itemHistoricoColumnPreco] ?? 0.0,
      total: map[itemHistoricoColumnTotal] ?? 0.0,
      categoria: map[itemHistoricoColumnCategoria] ?? '',
    );
  }
  
}