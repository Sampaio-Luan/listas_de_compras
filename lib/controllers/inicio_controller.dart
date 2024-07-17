import 'package:flutter/material.dart';

import '../preferencias_usuario.dart';

import 'itens_controller.dart';
import 'listas_controller.dart';

class IniciarAppController extends ChangeNotifier {
  ListasController listasController;
  PreferenciasUsuarioShared preferencias;
  ItensController itensController;
  int idUltimaLista = -1;
  String titulo = '';
  bool jaExecutado = false;

  IniciarAppController(
      {required this.listasController,
      required this.preferencias,
      required this.itensController});

  carregarPagina() async {
    bool iniciaLista = await listasController.recuperarListas();
    bool iniciaItens = false;
    if (iniciaLista) {
      idUltimaLista = await preferencias.idUltimaListaVisitada;
      titulo = listasController
          .listas[listasController.listas.indexOf(listasController.listas
              .firstWhere((element) => element.id == idUltimaLista))]
          .nome;
      iniciaItens = await itensController.iniciarController(
          idLista: idUltimaLista, nomeLista: titulo);

      debugPrint(
          '😶‍🌫️🥱IAC carregarPagina():  id: $idUltimaLista, nome:$titulo');
    }

    if (iniciaLista && iniciaItens) {
      return true;
    } else {
      return false;
    }
  }
}
