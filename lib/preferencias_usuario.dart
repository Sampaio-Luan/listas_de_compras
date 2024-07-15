import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuarioShared extends ChangeNotifier {
  late final SharedPreferences _prefs;

//#region ===================== * ATRIBUTOS * ===================================

  late bool _temaEscuro;
  bool get temaEscuro => _temaEscuro;

  late int _idUltimaListaVisitada;
  int get idUltimaListaVisitada => _idUltimaListaVisitada;

//#endregion =====================================================================
  PreferenciasUsuarioShared() {
    _inicializar();
  }

  _inicializar() async {
    _prefs = await SharedPreferences.getInstance();
    _temaEscuro = _prefs.getBool('temaEscuro') ?? false;
    _idUltimaListaVisitada = _prefs.getInt('idUltimaLista') ?? 0;

    notifyListeners();
  }

  setUltimaListaVisitada(int id) async {
    _idUltimaListaVisitada = id;
    _prefs.setInt('idUltimaLista', _idUltimaListaVisitada);
  }

  mudarTema() async {
    _temaEscuro = !_temaEscuro;
    _prefs.setBool('temaEscuro', _temaEscuro);

    notifyListeners();
  }
}
