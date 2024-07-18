import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/lista.module.dart';
import '../repositories/listas_repository.dart';

import 'itens_controller.dart';

class ListasController extends ChangeNotifier {
  String _ordenarPor = '';
  String get ordenarPor => _ordenarPor;
  List<ListaModel> _listas = [];
  UnmodifiableListView<ListaModel> get listas => UnmodifiableListView(_listas);

  recuperarListas() async {
    if (_listas.isEmpty) {
    
    _listas = await ListasRepository().recuperarListas() ;
    debugPrint('🤹📝CTL _recuperarListas():if ${_listas.length}');

    notifyListeners();
      return true;
    }
    debugPrint('🤹📝CTL _recuperarListas(): fora if ${_listas.length}');
    return true;
  }

  inserirLista(ListaModel lista) async {
    int id = await ListasRepository().inserirLista(lista);
    debugPrint('🤹📝CTL inserirLista(): id recuperado $id');
    _listas.clear();

    recuperarListas();
    ItensController().iniciarController(idLista: id, nomeLista: lista.nome);

    debugPrint('🤹📝CTL inserirLista(): ${lista.nome}');
  }

  atualizarLista(ListaModel lista) async {
    await ListasRepository().atualizarLista(lista);
    _listas[_listas.indexOf(lista)] = lista;
    // await Future.delayed(const Duration(seconds: 3), () {});

    debugPrint('🤹📝CTL atualizarLista(): ${lista.nome}');

    notifyListeners();
  }

  excluirLista(ListaModel lista) async {
    await ListasRepository().excluirLista(lista);
    _listas.removeWhere((element) => element.id == lista.id);

    //await Future.delayed(const Duration(seconds: 3), () {});

    debugPrint('🤹📝CTL excluirLista(): ${lista.nome}');

    notifyListeners();
  }

  ordenarListas(String ordem) {
    _ordenarPor = ordem;
    notifyListeners();
  }

  qtdItensLista(int idLista, int qtdItem) {
    for (int i = 0; i < _listas.length; i++) {
      if (_listas[i].id == idLista) {
        debugPrint(
            '🤹📝CTL qtdItensLista(): lista: ${_listas[i].nome} antes${_listas[i].totalItens}');
        _listas[i].totalItens = qtdItem;
        debugPrint(
            '🤹📝CTL qtdItensLista(): lista: ${_listas[i].nome} antes${_listas[i].totalItens}');
        break;
      }
    }

    notifyListeners();
  }

  qtdItensCompradosLista(int idLista) {
    debugPrint(
        '🤹📝CTL qtdItensCompradosLista(): tamanho lista: ${_listas.isEmpty}');
    for (var i in _listas) {
      debugPrint('🤹📝CTL qtdItensCompradosLista(): ids: ${i.id}');
    }
    debugPrint('🤹📝CTL qtdItensCompradosLista(): chamou id $idLista');
    for (int i = 0; i < _listas.length; i++) {
      debugPrint('🤹📝CTL qtdItensCompradosLista(): entrou no for');
      if (_listas[i].id == idLista) {
        debugPrint('🤹📝CTL qtdItensCompradosLista(): entrou no if');
        debugPrint(
            '🤹📝CTL qtdItensCompradosLista(): lista: ${_listas[i].nome} antes${_listas[i].totalComprados}');
        _listas[i].totalComprados = _listas[i].totalComprados + 1;
        debugPrint(
            '🤹📝CTL qtdItensCompradosLista(): lista: ${_listas[i].nome} antes${_listas[i].totalComprados}');
        break;
      }
    }

    notifyListeners();
  }
}
