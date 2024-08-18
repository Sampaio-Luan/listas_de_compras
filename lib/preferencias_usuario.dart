import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuarioShared extends ChangeNotifier {
  late final SharedPreferences _prefs;

//#region ===================== * ATRIBUTOS * ===================================

  bool _temaEscuro = false;
  bool get temaEscuro => _temaEscuro;

  int _temaDeCores = 0;
  int get temaDeCores => _temaDeCores;

  int  _idUltimaListaVisitada = -1;
  get idUltimaListaVisitada => _idUltimaListaVisitada;

  bool _isVerPorCategoria = true;
  bool get verPorCategoria => _isVerPorCategoria;

//#endregion =====================================================================
  PreferenciasUsuarioShared() {
    _inicializar();
  }

  _inicializar() async {
    _prefs = await SharedPreferences.getInstance();
    _temaEscuro = _prefs.getBool('temaEscuro') ?? false;
    _temaDeCores = _prefs.getInt('temaDeCores') ?? 0;
    _idUltimaListaVisitada = _prefs.getInt('idUltimaLista') ?? -1;
    _isVerPorCategoria = _prefs.getBool('verPorCategoria') ?? true;
    debugPrint('📲😎Pref, temaEscuro: $_temaEscuro, cor: $_temaDeCores, ver Por Categoria: $_isVerPorCategoria, idUltimaListaVisitada: $_idUltimaListaVisitada');
    notifyListeners();
  }

  setUltimaListaVisitada(int id) async {
    _idUltimaListaVisitada = id;
    _prefs.setInt('idUltimaLista', _idUltimaListaVisitada);
   debugPrint('📲😎Pref, setUltimaListaVisitada(): $_idUltimaListaVisitada');
  }

  setTemaDeCores(int index) async {
    _temaDeCores = index;
    _prefs.setInt('temaDeCores', _temaDeCores);
    debugPrint('📲😎Pref, setTemaDeCores(): $_temaDeCores');

    notifyListeners();
  }

  setVerPorCategoria(bool value) async {
    _isVerPorCategoria = value;
    _prefs.setBool('verPorCategoria', _isVerPorCategoria);
    debugPrint('📲😎Pref, setVerPorCategoria(): $_isVerPorCategoria');
  }

  mudarTema() async {
    _temaEscuro = !_temaEscuro;
    _prefs.setBool('temaEscuro', _temaEscuro);

    notifyListeners();
  }
}
