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

  final List<Map<String, int>> itensPadrao = [
//AÇOUGUE
    {'Carne moída': 0},
    {'Carne do sol': 0},
    {'Picanha': 0},
    {'Alcatra': 0},
    {'Coxão duro': 0},
    {'Coxão mole': 0},
    {'Cupim': 0},
    {'Costela': 0},
    {'Fígado': 0},
    {'Linguiça toscana': 0},
    {'Salsicha': 0},
    {'Coxinha da asa de frango': 0},
    {'Filé de frango': 0},
//BASICOS
    {'Arroz': 1},
    {'Feijão': 1},
    {'Macarrão': 1},
    {'Grão-de-bico': 1},
    {'Lentilha': 1},
    {'Açúcar': 1},
    {'Sal': 1},
    {'Óleo': 1},
    {'Azeite': 1},
    {'Temperos prontos': 1},
    {'Maionese': 1},
    {'Extrato de tomate': 1},
    {'Molho de tomate': 1},
    {'Fermento': 1},
    {'Massa para bolo': 1},
    {'Farinha de trigo': 1},
    {'Farofa': 1},
    {'Café': 1},
    {'Chá': 1},
    {'Leite': 1},
    {'Bolacha': 1},
    {'Biscoito': 1},

//BEBIDAS
    {'Água': 2},
    {'Leite': 2},
    {'Sucos': 2},
    {'Água de coco': 2},
    {'Refrigerante': 2},
    {'Cerveja': 2},
    {'Vinho': 2},
    {'Chá pronto': 2},
    {'Achocolatado': 2},
    {'Vodka': 2},
    {'Whiskey': 2},
    {'Cachaça': 2},
//CONGELADOS
    {'Frango': 3},
    {'Carne vermelha': 3},
    {'Peixe': 3},
    {'Lasanha': 3},
    {'Pizza': 3},
    {'Salsicha': 3},
    {'Hambúrguer': 3},
    {'Linguiça': 3},
    {'Pão de queijo': 3},
    {'Batata palito': 3},
    {'Pratos prontos': 3},
    {'Vegetais': 3},
    {'Frutas': 3},
    {'Sorvetes': 3},
    {'Pão de alho': 3},
//FEIRA
    {'Alface': 4},
    {'Cebola': 4},
    {'Cenoura': 4},
    {'Batata': 4},
    {'Tomate': 4},
    {'Pimenta': 4},
    {'Cebolinha': 4},
    {'Pimenta-do-reino': 4},
    {'Cebola-roxa': 4},
    {'Banana': 4},
    {'Laranja': 4},
    {'Lima': 4},
    {'Abacaxi': 4},
    {'Macaxeira': 4},
    {'Manga': 4},
    {'Uva': 4},
    {'Morango': 4},
    {'Maracuja': 4},
    {'Coco': 4},
    {'Cereja': 4},
    {'Caju': 4},
    {'Framboesa': 4},
    {'Abacate': 4},
    {'Melão': 4},
    {'Abobrinha': 4},
    {'Pepino': 4},
    {'Nectarina': 4},
    {'Melancia': 4},
    {'Melão': 4},
    {'Maçã': 4},
//FRIOS
    {'Presunto': 5},
    {'Apresuntado': 5},
    {'Mortadela': 5},
    {'Peito de peru': 5},
    {'Salame': 5},
    {'Requeijão': 5},
    {'Manteiga': 5},
    {'Margarina': 5},
    {'Leite Fermentado': 5},
    {'Iogurtes': 5},
    {'Sobremesas lácteas': 5},
//HIGIENE PESSOAL
    {'Shampoo': 6},
    {'Condicionador': 6},
    {'Sabonete': 6},
    {'Creme': 6},
    {'Escova de dentes': 6},
    {'Pomada': 6},
    {'Desodorante': 6},
    {'Papel higiênico': 6},
    {'Algodão': 6},
    {'Creme dental': 6},
    {'Creme hidratante': 6},
    {'Cotonete': 6},
    {'Esponja de banho': 6},
//LIMPEZA
    {'Água sanitária': 7},
    {'Desinfetante': 7},
    {'Detergente': 7},
    {'Esponja de aço': 7},
    {'Sabão em pó': 7},
    {'Amaciante': 7},
    {'Sabão em pedra': 7},
    {'Alvejante': 7},
    {'Vassoura': 7},
    {'Pá de lixo': 7},
    {'Rodo': 7},
    {'Pano de chão': 7},
    {'Pano de prato': 7},
    {'Luva de borracha': 7},
    {'Pedra sanitária': 7},
    {'Sacos de lixo': 7},
  ];
}
