import '../constants/const_tb_item_padrao.dart';

class ItemPadraoModel {

  int idItemPadrao;
  int idCategoria;
  String nome;


  ItemPadraoModel({
    required this.idItemPadrao,
    required this.idCategoria,
    required this.nome,
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    
    result.addAll({itemPadraoColumnId: idItemPadrao});
    result.addAll({itemPadraoColumnCategoriaId: idCategoria});
    result.addAll({itemPadraoColumnNome: nome});
    return result;
  }
  

  factory ItemPadraoModel.fromMap(Map<String, dynamic> map) {
    return ItemPadraoModel(
      idItemPadrao: map[itemPadraoColumnId] ?? 0,
      idCategoria: map[itemPadraoColumnCategoriaId] ?? 0,
      nome: map[itemPadraoColumnNome] ?? '');
  }
  
}