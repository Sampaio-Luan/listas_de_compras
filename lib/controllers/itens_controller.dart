import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/item.module.dart';
import '../repositories/itens_repository.dart';

class ItensController extends ChangeNotifier {
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
  double _total = 0;
  String get total => formatter.format(_total);

  final List<ItemModel> _itens = [];
  List<ItemModel> get itens => _itens;

  final List<ItemModel> _itensFiltrados = [];
  List<ItemModel> get itensFiltrados => _itensFiltrados;

  String _ordenarPor = '';
  String get ordenarPor => _ordenarPor;

  List<ItemModel> itemInterface = [];

  int _idLista = 0;

  iniciarControle(int idLista) {
    _idLista = idLista;
    recuperarItens();

  }

  recuperarItens() async {
    _itens.clear();
    _itensFiltrados.clear();
    itemInterface.clear();
    _total = 0;
    final itens = await ItensRepository().recuperarItens(_idLista);
    for (var item in itens) {
      _itens.add(item);
      
    }
    itemInterface.addAll(_itens);
    calculaTotal(_itens);
    notifyListeners();
  }

  ordenarItens(String ordem)async {
    _ordenarPor = ordem;
    itemInterface.clear();
    if (_ordenarPor == ordem) {
      _itens.sort((a, b) => a.nome.compareTo(b.nome));
    } else if (_ordenarPor == ordem) {
      _itens.sort((a, b) => b.nome.compareTo(a.nome));
    } else if (_ordenarPor == ordem) {
      _itens.sort((a, b) => b.preco.compareTo(a.preco));
    } else if (_ordenarPor == ordem) {
      _itens.sort((a, b) => a.preco.compareTo(b.preco));
    }
    for (var i in _itens) {
      itemInterface.add(i);
      debugPrint("Ordem: ${i.nome}");
    }
    notifyListeners();
  }

  filtrarItens(String filtro) {
    _itensFiltrados.clear();
    itemInterface.clear();
    if (filtro == 'Comprados') {
      for (var item in _itens) {
        if (item.comprado == 1) {
          _itensFiltrados.add(item);
        }
      }
    } else {
      for (var item in _itens) {
        if (item.comprado == 0) {
          _itensFiltrados.add(item);
        }
      }
    }

    for (var item in _itensFiltrados) {
      itemInterface.add(item);
      debugPrint("Filtro: ${item.nome}");
    }
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
    double t = 0;
    for (var item in itens) {
      if (item.comprado == 1) {
        t += item.preco * item.quantidade;
      }
    }
    _total = t;
    notifyListeners();
  }
}
