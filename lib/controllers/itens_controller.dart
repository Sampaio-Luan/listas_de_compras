import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/item.module.dart';
import '../repositories/itens_repository.dart';

class ItensController extends ChangeNotifier {
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

  String _ordenarPor = '';
  String _filtrarPor = '';
  double _precoTotal = 0;
  int _idLista = 2;

  String get filtrarPor => _filtrarPor;
  String get ordenarPor => _ordenarPor;
  String get precoTotal => formatter.format(_precoTotal);

  final List<ItemModel> _itensFiltrados = [];
  final List<ItemModel> _itensOrdenados = [];
  final List<ItemModel> _itens = [];

  List<ItemModel> get itens => _itens;
  List<ItemModel> get itensFiltrados => _itensFiltrados;
  List<ItemModel> get itensOrdenados => _itensOrdenados;

  ItensController() {
    iniciarControle(_idLista);
  }

  iniciarControle(int idLista) {
    _idLista = idLista;
    recuperarItens();
  }

  _limparTudo() {
    _itensFiltrados.clear();
    _itensOrdenados.clear();
    _itens.clear();
    _precoTotal = 0;
    _ordenarPor = '';
    _filtrarPor = '';
    notifyListeners();
  }

  recuperarItens() async {
    _limparTudo();

    final lItens = await ItensRepository().recuperarItens(_idLista);

    for (var item in lItens) {
      _itens.add(item);
    }

    calculaTotal(_itens);
  }

  ordenarItens(String ordem)  {
    _ordenarPor = ordem;
    _itensOrdenados.clear();

    if (ordem == 'A-z') {
      _itens.sort((ItemModel a, ItemModel b) => a.nome.compareTo(b.nome));
    } else if (ordem == 'Z-a') {
      _itens.sort((ItemModel a, ItemModel b) => b.nome.compareTo(a.nome));
    } else if (ordem == '+ Caro') {
      _itens.sort((ItemModel a, ItemModel b) => b.preco.compareTo(a.preco));
    }else{
      _itens.sort((ItemModel a, ItemModel b) => a.preco.compareTo(b.preco));
    }

      for (var i = 0; i < _itens.length; i++) {
        debugPrint('ordenar controller $ordem: ${_itens[i].nome} -- ${_itens[i].preco}');
      }
      
  
    notifyListeners();
  }

  filtrarItens(String filtro) {
    _itensFiltrados.clear();

    _itensOrdenados.clear();
    if (filtro == 'Comprados') {
      for (int i = 0; i < _itens.length; i++) {
        if (_itens[i].comprado == 1) {
          _itensFiltrados.add(_itens[i]);
        }
      }
    }else if (filtro == 'A comprar') {
      for (int i = 0; i < _itens.length; i++) {
        if (_itens[i].comprado == 0) {
          _itensFiltrados.add(_itens[i]);
        }
      }
    }else{
      _itensFiltrados.addAll(_itens);
    }
    for (var element in _itensFiltrados) {
      debugPrint("Filtro: ${element.nome}");
    }

    // for (var item in _itensFiltrados) {
    //   itemInterface.add(item);
    //   debugPrint("Filtro: ${item.nome}");
    // }
    notifyListeners();
  }

  adicionarItem(ItemModel item) {
    _itens.add(item);
    calculaTotal(_itens);
    ItensRepository().inserirItem(item);
    notifyListeners();
  }

  removerItem(ItemModel item) {
    _itens.remove(item);
    calculaTotal(_itens);
    ItensRepository().excluirItem(item);
    notifyListeners();
  }

  atualizarItem(ItemModel item) {
    _itens[_itens.indexOf(item)] = item;
    calculaTotal(_itens);
    ItensRepository().atualizarItem(item);
    notifyListeners();
  }

  calculaTotal(List<ItemModel> itens) {
    double total = 0;
    for (var item in itens) {
      if (item.comprado == 1) {
        total += item.preco * item.quantidade;
      }
    }
    _precoTotal = total;
    notifyListeners();
  }
}
