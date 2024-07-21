import 'dart:convert';

import '../constants/const_tb_lista.dart';

class ListaModel {
  int id;
  String nome;
  String criacao;
  int indice;
  String tema;
  int totalItens;
  int totalComprados;

  ListaModel({
    required this.id,
    required this.nome,
    required this.criacao,
    required this.indice,
    required this.tema,
    required this.totalItens,
    required this.totalComprados,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({listaColumnName: nome});
    result.addAll({listaColumnCriacao: criacao});
    result.addAll({listaColumnIndice: indice});
    result.addAll({listaColumnTema: tema});

    return result;
  }

  factory ListaModel.fromMap(Map<String, dynamic> map) {
    return ListaModel(
      id: map[listaColumnId] ?? 0,
      nome: map[listaColumnName] ?? '',
      criacao: map[listaColumnCriacao] ?? '',
      indice: map[listaColumnIndice] ?? 0,
      tema: map[listaColumnTema] ?? '',
      totalItens: map['total_itens'] ?? 0,
      totalComprados: map['itens_comprados'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListaModel.fromJson(String source) =>
      ListaModel.fromMap(json.decode(source));
}
