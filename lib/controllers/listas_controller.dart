import 'package:flutter/material.dart';

import '../models/lista.module.dart';
import '../repositories/listas_repository.dart';

import 'itens_controller.dart';

class ListasController extends ChangeNotifier {
  String _ordenarPor = '';
  String get ordenarPor => _ordenarPor;
  List<ListaModel> _listas = [];
  List<ListaModel> get listas => _listas;

  ListasController() {
    _iniciaControllerLista();
    debugPrint('🤹🏻📝CTL intanciada ListasController');
  }

  _iniciaControllerLista() async {
    if (_listas.isEmpty) {
      _recuperarListas();
    }
  }

  _recuperarListas() async {
    _listas = await ListasRepository().recuperarListas();
    debugPrint('🤹📝CTL _recuperarListas(): ${_listas.length}');

    // int idLista = _listas[0].id;
    // String nome = _listas[0].nome;

    // debugPrint('🤹📝CTL _recuperarListas(): $idLista, $nome');
    // debugPrint('🤹📝CTL _recuperarListas(): chamando a pagina');
    // ItensController().iniciarController(idLista: idLista, nomeLista: nome);

    notifyListeners();
  }

  inserirLista(ListaModel lista) async {
    int id = await ListasRepository().inserirLista(lista);
    debugPrint('🤹📝CTL inserirLista(): id recuperado $id');
    _listas.clear();

    _recuperarListas();
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
}
