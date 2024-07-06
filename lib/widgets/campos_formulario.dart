import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

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


class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    double value = double.parse(newValue.text);
    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
    String newText = formatter.format(value / 100);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
