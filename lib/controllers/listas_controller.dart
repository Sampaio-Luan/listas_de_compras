import 'package:flutter/material.dart';

import '../models/lista.module.dart';

class ListasController extends ChangeNotifier {
  String _ordenarPor = '';
  String get ordenarPor => _ordenarPor;
  final List<ListaModel> _listas = [];
  List<ListaModel> get listas => _listas;

  ordenarListas(String ordem) {
    _ordenarPor = ordem;
    notifyListeners();
  }
}
