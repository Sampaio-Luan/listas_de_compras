import 'dart:convert';

import '../constants/const_tb_item.dart';


class ItemModel {
  int idItem;
  int idLista;
  String nome;
  String descricao;
  double quantidade;
  String medida;
  double preco;
  int comprado;
  int indice;
  int prioridade;
  int idCategoria;

  ItemModel({
    required this.idItem,
    required this.idLista,
    required this.nome,
    required this.descricao,
    required this.quantidade,
    required this.medida,
    required this.preco,
    required this.comprado,
    required this.indice,
    required this.prioridade,
    required this.idCategoria
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    

    result.addAll({itemColumnListaId: idLista});
    result.addAll({itemColumnName: nome});
    result.addAll({itemColumnDescricao: descricao});
    result.addAll({itemColumnQuantidade: quantidade});
    result.addAll({itemColumnMedida: medida});
    result.addAll({itemColumnPreco: preco});
    result.addAll({itemColumnComprado: comprado});
    result.addAll({itemColumnIndice: indice});
    result.addAll({itemColumnPrioridade: prioridade});
    result.addAll({itemColumnCategoriaId: idCategoria});
  
    return result;
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      idItem: map[itemColumnId] ?? 0,
      idLista: map[itemColumnListaId] ?? 0,
      nome: map[itemColumnName] ?? '',
      descricao: map[itemColumnDescricao] ?? '',
      quantidade: map[itemColumnQuantidade] ?? 0.0,
      medida: map[itemColumnMedida] ?? '',
      preco: map[itemColumnPreco] ?? 0.0,
      comprado: map[itemColumnComprado] ?? 0,
      indice: map[itemColumnIndice] ?? 0,
      prioridade: map[itemColumnPrioridade] ?? 0,
      idCategoria: map[itemColumnCategoriaId] ?? 0
      
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source));
}
