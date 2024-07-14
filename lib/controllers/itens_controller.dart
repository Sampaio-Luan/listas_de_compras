import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../constants/const_strings_globais.dart';
import '../models/item.module.dart';
import '../repositories/itens_repository.dart';

class ItensController extends ChangeNotifier {
//#region ================== PROPRIEDADES ========================================
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

  double _precoTotal = 0;
  int _idLista = 0;

  String get precoTotal => formatter.format(_precoTotal);

  List<ItemModel> _itens = [];
  UnmodifiableListView<ItemModel> get itens => UnmodifiableListView(_itens);

  final List<ItemModel> _itensInterface = [];
  UnmodifiableListView<ItemModel> get itensInterface =>
      UnmodifiableListView(_itensInterface);

  final List<ItemModel> _itensSelecionados = [];
  UnmodifiableListView<ItemModel> get itensSelecionados =>
      UnmodifiableListView(_itensSelecionados);

  List<ItemModel> _itensPesquisados = [];
  UnmodifiableListView<ItemModel> get itensPesquisados =>
      UnmodifiableListView(_itensPesquisados);

  String _filtro = '';
  String get filtro => _filtro;

  String _ordem = '';
  String get ordem => _ordem;

  bool _isMarcadoTodosItens = false;
  bool get isMarcadoTodosItens => _isMarcadoTodosItens;
  set setIsMarcadoTodosItens(value) {
    _isMarcadoTodosItens = value;
  }

  bool _isPesquisar = false;
  bool get isPesquisar => _isPesquisar;
  set setIsPesquisar(value) {
    _isPesquisar = value;
    notifyListeners();
  }

//#endregion =====================================================================

  iniciarController({required int idLista}) {
    _idLista = idLista;
    _limparTudo();
    _recuperarItens();
  }

  _limparTudo() {
    _itensInterface.clear();
    _itens.clear();
    _itensPesquisados.clear();
    _itensSelecionados.clear();
    _precoTotal = 0;
    _filtro = '';
    _ordem = '';
    _isMarcadoTodosItens = false;
    _isPesquisar = false;
    debugPrint("limpar tudo");
  }

  _recuperarItens() async {
    _itens = await ItensRepository().recuperarItens(_idLista);
    debugPrint("itens controller: ${_itens.length}");

    _itensInterface.addAll(_itens);
    debugPrint("controller interface recuperar: ${_itensInterface.length}");

    int verificarComprados = 0;
    for (int i = 0; i < _itens.length; i++) {
      if (_itens[i].comprado == 1) {
        verificarComprados++;
      }
      debugPrint('itens Interface controller: ${_itensInterface[i].nome}');
      debugPrint('itens _itens controller: ${_itens[i].nome}');
    }

    if (verificarComprados == _itensInterface.length) {
      _isMarcadoTodosItens = true;
      debugPrint(
          'marcado todos itens recuperar controller: $_isMarcadoTodosItens');
    }

    _calculaTotal();

    debugPrint("notificou os listeners apos recuperar itens e itens interface");
  }

  _rebuildInterface() {
    _itensInterface.clear();
    notifyListeners();
  }

  ordenarItens(String ordem) async {
    _ordem = ordem;
    debugPrint('Ordem no controller: $_ordem');
    _rebuildInterface();
    await Future.delayed(const Duration(milliseconds: 300), () {
      debugPrint('Reordenando itens');
    });
    if (ordem == kAz) {
      _itens.sort((ItemModel a, ItemModel b) =>
          a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
    } else if (ordem == kZa) {
      _itens.sort((ItemModel a, ItemModel b) =>
          b.nome.toLowerCase().compareTo(a.nome.toLowerCase()));
    } else if (ordem == kCaro) {
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

  filtrarItens(String filtro) async {
    _filtro = filtro;
    debugPrint('Filtro no controller: $_filtro');

    _rebuildInterface();

    await Future.delayed(const Duration(milliseconds: 300), () {
      debugPrint('Filtrando itens.'); // Prints after 1 second.
    });

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

    notifyListeners();
  }

  adicionarItem(ItemModel item) async {
    ItensRepository().inserirItem(item);
    _itens.add(item);
    _itensInterface.add(item);

    _calculaTotal();
  }

  removerItem(ItemModel item) async {
    ItensRepository().excluirItem(item);
    _itens.remove(item);
    _itensInterface.remove(item);

    _calculaTotal();
  }

  atualizarItem(ItemModel item) async {
    ItensRepository().atualizarItem(item);
    _itens[_itens.indexOf(item)] = item;
    _itensInterface[_itensInterface.indexOf(item)] = item;

    _calculaTotal();
  }

  marcarTodos() async {
    debugPrint('marcado todos itens funcao controller: $_isMarcadoTodosItens');
    _rebuildInterface();
    await Future.delayed(const Duration(milliseconds: 300), () {
      debugPrint('Controle Marcando/Desmarcando todos itens');
    });
    if (_isMarcadoTodosItens) {
      for (int i = 0; i < _itens.length; i++) {
        _itens[i].comprado = 0;
      }
      _isMarcadoTodosItens = !_isMarcadoTodosItens;
      debugPrint(
          'marcado todos itens sair do if controller: $_isMarcadoTodosItens');
      ItensRepository().desmarcarTodosItens(idLista: _idLista);
    } else {
      for (int i = 0; i < _itens.length; i++) {
        _itens[i].comprado = 1;
      }
      _isMarcadoTodosItens = !_isMarcadoTodosItens;
      debugPrint(
          'marcado todos itens sair do else controller: $_isMarcadoTodosItens');
      ItensRepository().marcarTodosItens(idLista: _idLista);
    }

    _itensInterface.addAll(_itens);

    _calculaTotal();
  }

  _calculaTotal() {
    double total = 0;
    for (var item in _itens) {
      if (item.comprado == 1) {
        total += item.preco * item.quantidade;
      }
    }
    _precoTotal = total;
    notifyListeners();
  }

  pesquisar({required String pesquisarPor}) async {
    _rebuildInterface();

    await Future.delayed(const Duration(milliseconds: 100), () {
      debugPrint('Pesquisando itens.');
    });
    _itensPesquisados = _itens
        .where((element) =>
            element.nome.toLowerCase().contains(pesquisarPor.toLowerCase()))
        .toList();
    _itensInterface.addAll(_itensPesquisados);
    notifyListeners();
  }

  selecionarItens(ItemModel item) {
    if (_itensSelecionados.contains(item)) {
      _itensSelecionados.remove(item);
    } else {
      _itensSelecionados.add(item);
    }

    debugPrint(
        'Selecionado itens controller: ${_itensSelecionados.length}');
    notifyListeners();
  }

  limparListaSelecionados() {
    _itensSelecionados.clear();
    notifyListeners();
  }

  excluirItensSelecionados()async{
    for (var item in _itensSelecionados) {
      await ItensRepository().excluirItem(item);
      _itens.remove(item);
      _itensInterface.remove(item);
    }
    debugPrint ('Excluido itens selecionados controller');

    _calculaTotal();
    limparListaSelecionados();
  }
}
