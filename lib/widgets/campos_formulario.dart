import 'package:flutter/material.dart';

import 'package:listas_de_compras/theme/estilos.dart';

class CamposFormulario {
// #region 
  linha(
    context, {
    required TextEditingController controle,
    required String label,
    required int qtdLinha,
    required bool valida,
  }) {
    return TextField(
      controller: controle,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Estilos().corpoColor(context, tamanho: 'p'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      maxLines: qtdLinha,
    );
  }
// #endregion
}
