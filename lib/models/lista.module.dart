import 'dart:convert';

import '../constants/const_tb_lista.dart';

class ListaModel {
  int id;
  String nome;
  String descricao;
  String criacao;
  int indice;
  String icone;
  String tema;
  int totalItens;
  int totalComprados;

  ListaModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.criacao,
    required this.indice,
    required this.icone,
    required this.tema,
    required this.totalItens,
    required this.totalComprados,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    
    
    result.addAll({listaColumnName: nome});
    result.addAll({listaColumnDescricao: descricao});
    result.addAll({listaColumnCriacao: criacao});
    result.addAll({listaColumnIndice: indice});
    result.addAll({listaColumnIcone: icone});
    result.addAll({listaColumnTema: tema});

    return result;
  }

  factory ListaModel.fromMap(Map<String, dynamic> map) {
    return ListaModel(
      id: map[listaColumnId] ?? 0,
      nome: map[listaColumnName] ?? '',
      descricao: map[listaColumnDescricao] ?? '',
      criacao: map[listaColumnCriacao] ?? '',
      indice: map[listaColumnIndice] ?? 0,
      icone: map[listaColumnIcone] ?? '',
      tema: map[listaColumnTema] ?? '',
      totalItens: map['total_itens'] ?? 0,
      totalComprados: map['itens_comprados'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListaModel.fromJson(String source) =>
      ListaModel.fromMap(json.decode(source));
}
