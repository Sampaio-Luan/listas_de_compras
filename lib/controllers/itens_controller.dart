import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../constants/const_strings_globais.dart';
import '../constants/const_tb_item.dart';
import '../models/item.module.dart';
import '../repositories/itens_repository.dart';

import 'listas_controller.dart';

class ItensController extends ChangeNotifier {
//#region =================== * ATRIBUTOS * ====================================
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
  final formatoData = DateFormat.jms('pt_BR');

  double _precoTotal = 0;
  double _precoTotalLista = 0;
  int _idLista = -1;
  int get getIdLista => _idLista;

  int _totalItensComprados = 0;
  int get totalItensComprados => _totalItensComprados;

  String _nomeLista = '';
  String get nomeLista => _nomeLista;

  String get precoTotal => formatter.format(_precoTotal);
  String get precoTotalLista => formatter.format(_precoTotalLista);

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

  bool _isPesquisar = false;
  bool get isPesquisar => _isPesquisar;

  bool _isFormCompleto = false;
  bool get isFormCompleto => _isFormCompleto;

  bool _isFormEdicao = false;
  bool get isFormEdicao => _isFormEdicao;

  ItemModel? _itemParaEdicaoForm;
  ItemModel? get itemParaEdicaoForm => _itemParaEdicaoForm;

//#endregion ================ * END ATRIBUTOS * ================================

//#region =================== * METODOS * ======================================

//#region =================== * CONTROLLER * ===================================

  iniciarController({required int idLista, required String nomeLista}) {
    if (idLista != _idLista) {
      _idLista = idLista;
      _nomeLista = nomeLista;
      debugPrint(
          '====== (${formatoData.format(DateTime.now())}) Nova Solicitação - $nomeLista =====================');
      debugPrint(
          '🤴🏻🧺CTi iniciarController(): _idLista $_idLista, _nomeLista $_nomeLista');
      _limparTudo();
      notifyListeners();
      _recuperarItens();
      return true;
    }
  }

//#endregion ================ * END CONTROLLER * ===============================

//#region =================== * RECUPERAR * ====================================

  _recuperarItens() async {
    _itens = await ItensRepository().recuperarItens(_idLista);
    debugPrint("🤴🏻🧺CTi _recuperarItens() _itens: ${_itens.length}");

    _itensInterface.addAll(_itens);
    debugPrint(
        "🤴🏻🧺CTi _recuperarItens() _itensInterface: ${_itensInterface.length}");

    notifyListeners();
    _calculaTotal();
    _calculaPrecoTotalLista();
    return _itens;
  }

//#endregion ================ * END RECUPERAR * ================================

//#region =================== * INSERIR * ======================================

  adicionarItem(ItemModel item, ListasController lista) async {
    int id = await ItensRepository().inserirItem(item);
    item.idItem = id;
    _itens.add(item);
    _itensInterface.add(item);
    debugPrint("🤴🏻🧺CTi adicionarItem() item: ${item.nome}");
    lista.qtdItensLista(_idLista,_itens.length);
    _calculaTotal();

    _calculaPrecoTotalLista();
  }

//#endregion ================ * END INSERIR * ==================================

//#region =================== * ALTERAR * ======================================

  atualizarItem(ItemModel item) async {
    await ItensRepository().atualizarItem(item);
    _itens[_itens.indexOf(item)] = item;
    _itensInterface[_itensInterface.indexOf(item)] = item;
    debugPrint('🤴🏻🧺CTi atualizarItem() item: ${item.nome}');
    _calculaTotal();
    _calculaPrecoTotalLista();
  }

  set setIsMarcadoTodosItens(value) {
    _isMarcadoTodosItens = value;
  }

  marcarDesmarcarItem(ItemModel item, ListasController lista) async {
    final mOUd = await ItensRepository().editarUmAtributo(
      campo: itemColumnComprado,
      valor: item.comprado,
      item: item,
    );

    if (mOUd) {
      _itens[_itens.indexOf(item)] = item;
      _itensInterface[_itensInterface.indexOf(item)] = item;

      int comprados = _calculaTotal();
      lista.qtdItensCompradosLista(_idLista, comprados);

      //notifyListeners();
    }
    debugPrint('🤴🏻🧺 CTi marcarDesmarcarItem() item: ${item.nome}');
  }

  marcarTodos(ListasController lista) async {
    _rebuildInterface();

    await Future.delayed(const Duration(milliseconds: 300), () {
      debugPrint('🤴🏻🧺CTi marcarTodos() delay');
    });
    if (_isMarcadoTodosItens) {
      for (int i = 0; i < _itens.length; i++) {
        _itens[i].comprado = 0;
      }

      debugPrint(
          '🤴🏻🧺CTi marcarTodos() marcar todos itens?: $_isMarcadoTodosItens');
      _isMarcadoTodosItens = !_isMarcadoTodosItens;

      ItensRepository().desmarcarTodosItens(idLista: _idLista);
      lista.qtdItensCompradosLista(_idLista, 0);
    } else {
      for (int i = 0; i < _itens.length; i++) {
        _itens[i].comprado = 1;
      }

      debugPrint(
          '🤴🏻🧺CTi marcarTodos() marcado todos? : $_isMarcadoTodosItens');
      _isMarcadoTodosItens = !_isMarcadoTodosItens;

      ItensRepository().marcarTodosItens(idLista: _idLista);
      lista.qtdItensCompradosLista(_idLista, _itens.length);
    }

    _itensInterface.addAll(_itens);

    _calculaTotal();
  }

//#endregion ================ * END ALTERAR * ==================================

//#region =================== * DELETAR * ======================================

  removerItem(ItemModel item, ListasController lista) async {
    await ItensRepository().excluirItem(item);
    _itens.remove(item);
    _itensInterface.remove(item);
    lista.qtdItensLista(_idLista, _itens.length);
    debugPrint('🤴🏻🧺CTi removerItem() item: ${item.nome}');
    _calculaTotal();
    _calculaPrecoTotalLista();
  }

  removerComEndDrawer(String nome, ListasController lista) async {
    for (int i = 0; i < _itens.length; i++) {
      if (_itens[i].nome.toLowerCase() == nome.toLowerCase()) {
        removerItem(_itens[i], lista);
        debugPrint('🤴🏻🧺CTi removerComEndDrawer() item: ${_itens[i].nome}');

        break;
      }
    }
  }

//#endregion ================ * END DELETAR * ==================================

//#region =================== * FILTRAR * ======================================

  filtrarItens(String filtro) async {
    _filtro = filtro;
    debugPrint('🤴🏻🧺CTi filtrarItens() _filto: $_filtro');

    _rebuildInterface();

    await Future.delayed(const Duration(milliseconds: 300), () {
      debugPrint('🤴🏻🧺CTi filtrarItens() delay'); // Prints after 1 second.
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
    debugPrint('\n\n');
    for (var element in _itensInterface) {
      debugPrint(
          "🤴🏻🧺CTi filtrarItens() _filtro($_filtro) _itensIterface.nome: ${element.nome}");
    }
    debugPrint('\n\n');

    notifyListeners();
  }

//#endregion ================ * END FILTRAR * ==================================

//#region =================== * ORDENAR * ======================================

  ordenarItens(String ordem) async {
    _ordem = ordem;
    debugPrint('🤴🏻🧺CTi ordenarItens() _ordem: $_ordem');
    _rebuildInterface();
    await Future.delayed(const Duration(milliseconds: 300), () {
      debugPrint('🤴🏻🧺CTi ordenarItens() delay executado');
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
    debugPrint('\n\n');

    for (var i = 0; i < _itens.length; i++) {
      _itensInterface.add(_itens[i]);
      debugPrint(
          '🤴🏻🧺CTi ordenarItens() _ordem ($_ordem):_itens nome${_itens[i].nome} --_itens preço${_itens[i].preco}');
    }
    debugPrint('\n\n');

    notifyListeners();
  }

//#endregion ================ * END ORDENAR * ==================================

//#region =================== * PESQUISAR * ====================================

  set setIsPesquisar(value) {
    _isPesquisar = value;
    notifyListeners();
  }

  pesquisar({required String pesquisarPor}) async {
    _rebuildInterface();

    await Future.delayed(const Duration(milliseconds: 100), () {
      debugPrint('🤴🏻🧺 CTi pesquisar() delay');
    });
    _itensPesquisados = _itens
        .where((element) =>
            element.nome.toLowerCase().contains(pesquisarPor.toLowerCase()))
        .toList();
    _itensInterface.addAll(_itensPesquisados);
    notifyListeners();
  }

//#endregion ================ * END PESQUISAR * ================================

//#region =================== * SELECIONAR * ===================================

  selecionarItens(ItemModel item) {
    if (_itensSelecionados.contains(item)) {
      _itensSelecionados.remove(item);
    } else {
      _itensSelecionados.add(item);
    }

    debugPrint(
        '🤴🏻🧺 CTi selecionarItens() _itensSelecionados: ${_itensSelecionados.length}');
    notifyListeners();
  }

  limparListaSelecionados() {
    _itensSelecionados.clear();
    debugPrint(
        '🤴🏻🧺 CTi limparListaSelecionados() _itensSelecionados: ${_itensSelecionados.length}');
    notifyListeners();
  }

  excluirItensSelecionados(ListasController listaC) async {
    debugPrint(
        '🤴🏻🧺 CTi excluirItensSelecionados() qtd de itens antes: ${_itens.length}');
    for (var item in _itensSelecionados) {
      await ItensRepository().excluirItem(item);
      _itens.remove(item);
      _itensInterface.remove(item);
    }

    debugPrint(
        '🤴🏻🧺 CTi excluirItensSelecionados() qtd de itens após: ${_itens.length}');
listaC.qtdItensLista(_idLista, _itens.length);
    _calculaTotal();
    limparListaSelecionados();
  }

//#endregion ================ * END SELECIONAR * ===============================

//#region =================== * INTERFACE * ====================================

//#region =================== * LIMPAR TUDO * ==================================

  _limparTudo() {
    _itensInterface.clear();
    _itens.clear();
    _itensPesquisados.clear();
    _itensSelecionados.clear();
    _precoTotal = 0;
    _precoTotalLista = 0;
    _filtro = '';
    _ordem = '';
    _isMarcadoTodosItens = false;
    _isPesquisar = false;
    _isFormEdicao = false;
    _isFormCompleto = false;

    debugPrint('🤴🏻🧺CTi _limparTudo()');
  }

  _rebuildInterface() {
    _itensInterface.clear();
    debugPrint(
        "🤴🏻🧺CTi _rebuildInterface() _itensInterface: ${_itensInterface.length} ");
    notifyListeners();
  }

//#endregion ================ * END LIMPAR TUDO * ==============================

//#region =================== * CALCULAR * =====================================
  _calculaTotal() {
    double total = 0;
    _totalItensComprados = 0;

    for (var item in _itens) {
      if (item.comprado == 1) {
        total += item.preco * item.quantidade;
        _totalItensComprados += 1;
      }
    }
    _precoTotal = total;

    debugPrint('🤴🏻🧺CTi _calculaTotal() _precoTotal: $_precoTotal');

    notifyListeners();

    return _totalItensComprados;
  }

  _calculaPrecoTotalLista() {
    double total = 0;

    for (var item in _itens) {
      total += item.preco * item.quantidade;
    }
    _precoTotalLista = total;

    debugPrint(
        '🤴🏻🧺CTi _calculaPrecoTotalLista() _precoTotalLista: $_precoTotalLista');

    notifyListeners();
  }

//#endregion ================ * END CALCULAR * ==================================

//#region =================== * NOME DA LISTA * ================================

  setNomeLista(String nome) {
    _nomeLista = nome;
    debugPrint('🤴🏻🧺CTi setNomeLista() _nomeLista: $_nomeLista');

    notifyListeners();
  }
//#endregion ================ * END NOME DA LISTA * ============================

//#region =================== * FORMULARIO * ===================================

  setIsFormCompleto(bool value) {
    _isFormCompleto = value;
    debugPrint(
        '🤴🏻🧺CTi set isFormCompleto() _isFormCompleto: $_isFormCompleto');
    notifyListeners();
  }

  setIsFormEdicao(bool value) {
    _isFormEdicao = value;
    debugPrint('🤴🏻🧺CTi set setIsFormEdicao() _isFormEdicao: $_isFormEdicao');
    notifyListeners();
  }

  habilitarformEdicao(ItemModel item) {
    _itemParaEdicaoForm = item;
    _isFormCompleto = true;
    _isFormEdicao = true;

    debugPrint(
        '🤴🏻🧺CTi habilitarformEdicao() _formEdicao: item:${item.nome}, isFormCompleto: $_isFormCompleto, isFormEdicao $_isFormEdicao');

    notifyListeners();
  }

//#endregion ================ * END FORMULARIO * ===============================

//#endregion ================ * END INTERFACE * ================================

//#endregion ================ * END METODOS * ==================================
}
