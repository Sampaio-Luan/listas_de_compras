import 'dart:convert';

class ListaModel {
  int id;
  String nome;
  String descricao;
  String criacao;
  int indice;
  String icone;

  ListaModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.criacao,
    required this.indice,
    required this.icone,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    
    result.addAll({'nome_lista': nome});
    result.addAll({'descricao_lista': descricao});
    result.addAll({'criacao': criacao});
    result.addAll({'indice': indice});
    result.addAll({'icone': icone});

    return result;
  }

  factory ListaModel.fromMap(Map<String, dynamic> map) {
    return ListaModel(
      id: map['id'],
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      criacao: map['criacao'] ?? '',
      indice: map['indice']?.toInt() ?? 0,
      icone: map['icone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ListaModel.fromJson(String source) =>
      ListaModel.fromMap(json.decode(source));
}
