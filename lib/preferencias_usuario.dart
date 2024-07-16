import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuarioShared extends ChangeNotifier {
  late final SharedPreferences _prefs;

//#region ===================== * ATRIBUTOS * ===================================

  bool _temaEscuro = false;
  bool get temaEscuro => _temaEscuro;

  int ? _idUltimaListaVisitada ;
  get idUltimaListaVisitada => _idUltimaListaVisitada;

//#endregion =====================================================================
  PreferenciasUsuarioShared() {
    _inicializar();
  }

  _inicializar() async {
    _prefs = await SharedPreferences.getInstance();
    _temaEscuro = _prefs.getBool('temaEscuro') ?? false;
    _idUltimaListaVisitada = _prefs.getInt('idUltimaLista') ;
    debugPrint('📲😎Pref, temaEscuro: $_temaEscuro, idUltimaListaVisitada: $_idUltimaListaVisitada');
    notifyListeners();
  }

  setUltimaListaVisitada(int id) async {
    _idUltimaListaVisitada = id;
    _prefs.setInt('idUltimaLista', _idUltimaListaVisitada!);
   debugPrint('📲😎Pref, setUltimaListaVisitada(): $_idUltimaListaVisitada');
  }

  mudarTema() async {
    _temaEscuro = !_temaEscuro;
    _prefs.setBool('temaEscuro', _temaEscuro);

    notifyListeners();
  }
}
