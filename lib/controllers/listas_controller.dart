import 'package:flutter/material.dart';

import '../models/lista.module.dart';
import '../repositories/listas_repository.dart';

class ListasController extends ChangeNotifier {
  String _ordenarPor = '';
  String get ordenarPor => _ordenarPor;
  List<ListaModel> _listas = [];
  List<ListaModel> get listas => _listas;

  ListasController() {
    _initRepository();
  }

  _initRepository() async {
    _listas.clear();
    _recuperarListas();
  }

  _recuperarListas() async {
    _listas = await ListasRepository().recuperarListas();
    notifyListeners();
  }

  ordenarListas(String ordem) {
    _ordenarPor = ordem;
    notifyListeners();
  }
}
