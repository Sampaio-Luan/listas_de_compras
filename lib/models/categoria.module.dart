import '../constants/const_tb_categorias.dart';

class CategoriaModel {
  int id;
  String nome;
  int grau;

  CategoriaModel({
    required this.id,
    required this.nome,
    required this.grau,
  });


  Map<String, dynamic> toMap() {  
    final result = <String, dynamic>{};
    
    result.addAll({categoriaColumnName: nome});
    result.addAll({categoriaColumnGrau: grau});
    return result;
  }

  factory CategoriaModel.fromMap(Map<String, dynamic> map) {
    return CategoriaModel(
      id: map[categoriaColumnId] ?? 0,
      nome: map[categoriaColumnName] ?? '',
      grau: map[categoriaColumnGrau] ?? 0,
    );
  }
  
}