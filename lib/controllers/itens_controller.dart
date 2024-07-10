import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/item.module.dart';
import '../repositories/itens_repository.dart';

class ItensController extends ChangeNotifier {
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

  double _precoTotal = 0;
  int _idLista = 2;

  String get precoTotal => formatter.format(_precoTotal);

  final List<ItemModel> _itensInterface = [];
  final List<ItemModel> _itens = [];

  UnmodifiableListView<ItemModel> get itens => UnmodifiableListView(_itens);
  UnmodifiableListView<ItemModel> get itensInterface =>
      UnmodifiableListView(_itensInterface);

  iniciarController({required int idLista}) {
    _idLista = idLista;
    recuperarItens();
  }

  _limparTudo() {
    _itensInterface.clear();
    _itens.clear();
    _precoTotal = 0;
  }

  recuperarItens() async {
    _limparTudo();

    final lItens = await ItensRepository().recuperarItens(_idLista);

    debugPrint(
        "itens controller interface recuperar: ${_itensInterface.length}");
    preencher(lItens);
  }

  preencher(dynamic i) {
    for (var item in i) {
      _itens.add(item);
    }

    _itensInterface.addAll(_itens);
    debugPrint(
        "itens controller interface preencher: ${_itensInterface.length}");

    calculaTotal(_itens);
    notifyListeners();
  }

  _rebuildInterface() {
    _itensInterface.clear();
    notifyListeners();
  }

  ordenarItens(String ordem) {
    _rebuildInterface();

    _itensInterface.clear();

    if (ordem == 'A-z') {
      _itens.sort((ItemModel a, ItemModel b) => a.nome.compareTo(b.nome));
    } else if (ordem == 'Z-a') {
      _itens.sort((ItemModel a, ItemModel b) => b.nome.compareTo(a.nome));
    } else if (ordem == '+ Caro') {
      _itens.sort((ItemModel a, ItemModel b) => b.preco.compareTo(a.preco));
    } else {
      _itens.sort((ItemModel a, ItemModel b) => a.preco.compareTo(b.preco));
    }

    for (var i = 0; i < _itens.length; i++) {
      _itensInterface.add(_itens[i]);
      debugPrint(
          'ordenar controller $ordem: ${_itens[i].nome} -- ${_itens[i].preco}');
    }

    notifyListeners();
  }

  filtrarItens(String filtro) {
    _rebuildInterface();

    if (filtro == 'Comprados') {
      for (int i = 0; i < _itens.length; i++) {
        if (_itens[i].comprado == 1) {
          _itensInterface.add(_itens[i]);
        }
      }
    } else if (filtro == 'A comprar') {
      for (int i = 0; i < _itens.length; i++) {
        if (_itens[i].comprado == 0) {
          _itensInterface.add(_itens[i]);
        }
      }
    } else {
      _itensInterface.addAll(_itens);
    }
    for (var element in _itensInterface) {
      debugPrint("Filtro: ${element.nome}");
    }
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
    // notifyListeners();
  }
}
