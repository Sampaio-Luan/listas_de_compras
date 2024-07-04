import 'dart:convert';

class ItemModel {
  String nome;
  String descricao;
  double quantidade;
  double preco;
  bool comprado;
  int indice;

  ItemModel({
    required this.nome,
    required this.descricao,
    required this.quantidade,
    required this.preco,
    required this.comprado,
    required this.indice,
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'nome': nome});
    result.addAll({'descricao': descricao});
    result.addAll({'quantidade': quantidade});
    result.addAll({'preco': preco});
    result.addAll({'comprado': comprado});
    result.addAll({'indice': indice});
  
    return result;
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      quantidade: map['quantidade']?.toDouble() ?? 0.0,
      preco: map['preco']?.toDouble() ?? 0.0,
      comprado: map['comprado'] ?? false,
      indice: map['indice']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source));
}
