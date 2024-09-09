import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/lista.module.dart';
import '../preferencias_usuario.dart';
import '../repositories/listas_repository.dart';

import 'itens_controller.dart';

class ListasController extends ChangeNotifier {
//#region =================== * ATRIBUTOS * ==================================

  List<ListaModel> _listas = [];
  UnmodifiableListView<ListaModel> get listas => UnmodifiableListView(_listas);

//#endregion ================ * END ATRIBUTOS * ==============================

//#region =================== * METODOS * ====================================

//#region =================== * RECUPERAR * ==================================

  recuperarListas() async {
    if (_listas.isEmpty) {
      _listas = await ListasRepository().recuperarListas();
      debugPrint('🤹📝CTL _recuperarListas():if ${_listas.length}');

      notifyListeners();
      return true;
    }
    debugPrint('🤹📝CTL _recuperarListas(): fora if ${_listas.length}');
    return true;
  }

//#endregion ================ * END RECUPERAR * ==============================

//#region =================== * INCLUIR * ====================================

  inserirLista(ListaModel lista, ItensController itemC, PreferenciasUsuarioShared preferencias) async {
    int id = await ListasRepository().inserirLista(lista);
    debugPrint('🤹📝CTL inserirLista(): id recuperado $id');
    lista.id = id;
    _listas.add(lista);
   
    itemC.iniciarController(idLista: id, nomeLista: lista.nome);
    preferencias.setUltimaListaVisitada(id);

    debugPrint('🤹📝CTL inserirLista(): ${lista.nome}');

   notifyListeners();
  }

//#endregion ================ * END INCLUIR * ================================

//#region =================== * ALTERAR * ====================================

  atualizarLista(ListaModel lista) async {
    await ListasRepository().atualizarLista(lista);
    _listas[_listas.indexOf(lista)] = lista;
    // await Future.delayed(const Duration(seconds: 3), () {});

    debugPrint('🤹📝CTL atualizarLista(): ${lista.nome}');

    notifyListeners();
  }

//#endregion ================ * END ALTERAR * ================================

//#region =================== * EXCLUIR * ====================================

  excluirLista(ListaModel lista) async {

    await ListasRepository().excluirLista(lista);

    _listas.clear();
    notifyListeners();

    _listas = await ListasRepository().recuperarListas();
    
    //_listas.removeWhere((element) => element.id == lista.id);

    //await Future.delayed(const Duration(seconds: 3), () {});

    debugPrint('🤹📝CTL excluirLista(): ${lista.nome}');

    notifyListeners();
  }

//#endregion ================ * END EXCLUIR * ================================

//#region =================== * INTERFACE * ==================================

  qtdItensLista(int idLista, int qtdItem) {

    for (int i = 0; i < _listas.length; i++) {

      if (_listas[i].id == idLista) {

        debugPrint('🤹📝CTL qtdItensLista(): lista: ${_listas[i].nome}');
        debugPrint('🤹📝CTL qtdItensLista() antes: ${_listas[i].totalItens}');

        _listas[i].totalItens = qtdItem;

        debugPrint('🤹📝CTL qtdItensLista() apos: ${_listas[i].totalItens}');
        
        break;
      }
    }

    notifyListeners();
  }

  qtdItensCompradosLista(int idLista, int qtdItem) {

    for (int i = 0; i < _listas.length; i++) {

      if (_listas[i].id == idLista) {

        debugPrint('🤹📝CTL qtdItensCompradosLista() lista: ${_listas[i].nome}');
        debugPrint('🤹📝CTL qtdItensCompradosLista() antes: ${_listas[i].totalComprados}');

        _listas[i].totalComprados = qtdItem;

        debugPrint( '🤹📝CTL qtdItensCompradosLista() apos: ${_listas[i].totalComprados}');

        break;
      }
    }

    notifyListeners();
  }

//#endregion ================ * END INTERFACE * ==============================

//#endregion ================ * END METODOS * ================================
}
