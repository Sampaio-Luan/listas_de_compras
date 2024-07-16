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
    _initRepository();
    debugPrint('🤹🏻📝CTL intanciada ListasController');
  }

  _initRepository() async {
    if (_listas.isEmpty) {
      _recuperarListas();
    }
  }

  _recuperarListas() async {
    _listas = await ListasRepository().recuperarListas();
    debugPrint('🤹📝CTL _recuperarListas(): ${_listas.length}');

    int idLista = _listas[0].id;
    String nome = _listas[0].nome;

    debugPrint('🤹📝CTL _recuperarListas(): $idLista, $nome');
    debugPrint('🤹📝CTL _recuperarListas(): chamando a pagina');
    ItensController().iniciarController(idLista: idLista, nomeLista: nome);
    
    notifyListeners();
  }

  ordenarListas(String ordem) {
    _ordenarPor = ordem;
    notifyListeners();
  }
}
