import 'dart:convert';

import '../constants/db_constants.dart';
class ItemModel {
  int idItem;
  int idLista;
  String nome;
  String descricao;
  double quantidade;
  double preco;
  int comprado;
  int indice;

  ItemModel({
    required this.idItem,
    required this.idLista,
    required this.nome,
    required this.descricao,
    required this.quantidade,
    required this.preco,
    required this.comprado,
    required this.indice,
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({itemColumnListaId: idLista});
    result.addAll({itemColumnName: nome});
    result.addAll({itemColumnDescricao: descricao});
    result.addAll({itemColumnQuantidade: quantidade});
    result.addAll({itemColumnPreco: preco});
    result.addAll({itemColumnComprado: comprado});
    result.addAll({itemColumnIndice: indice});
  
    return result;
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      idItem: map[itemColumnId] ?? 0,
      idLista: map[itemColumnListaId] ?? 0,
      nome: map[itemColumnName] ?? '',
      descricao: map[itemColumnDescricao] ?? '',
      quantidade: map[itemColumnQuantidade] ?? 0,
      preco: map[itemColumnPreco] ?? 0,
      comprado: map[itemColumnComprado] ?? 0,
      indice: map[itemColumnIndice] ?? 0,
      
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source));
}
