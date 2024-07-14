import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuarioShared extends ChangeNotifier {
  late final SharedPreferences _prefs;

  late bool _temaEscuro ;
  bool get temaEscuro => _temaEscuro;

  PreferenciasUsuarioShared() {
    _inicializar();
  }

  _inicializar() async {
    _prefs = await SharedPreferences.getInstance();
    _temaEscuro = _prefs.getBool('temaEscuro') ?? false;

    notifyListeners();
  }

  mudarTema() {
    _temaEscuro = !_temaEscuro;
    _prefs.setBool('temaEscuro', _temaEscuro);
    notifyListeners();
  }

}
