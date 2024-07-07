import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

import '../mixins/validations_mixin.dart';
import '../theme/estilos.dart';

class CamposFormulario with ValidacoesMixin {
  linha(
    context, {
    required TextEditingController controle,
    required String label,
    required int qtdLinha,
    required bool valida,
  }) {
    return TextFormField(
      controller: controle,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Estilos().corpoColor(context, tamanho: 'p'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      maxLines: qtdLinha,
      validator: valida
          ? (value) => preenchimentoObrigatorio(input: value, message: null)
          : null,
    );
  }

  apenasNumeros(
    context, {
    required TextEditingController controle,
    required String label,
    required int qtdLinha,
    required bool valida,
  }) {
    return TextFormField(
      controller: controle,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Estilos().corpoColor(context, tamanho: 'p'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      maxLines: qtdLinha,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        LengthLimitingTextInputFormatter(4),
      ],
      validator: valida
          ? (value) => multiValidacoes(validacoes: [
                () => preenchimentoObrigatorio(input: value, message: null),
                () => valorMinimo(input: value)
              ])
          : null,
    );
  }

  moeda(
    context, {
    required TextEditingController controle,
    required String label,
    required bool valida,
  }) {
    return TextFormField(
      controller: controle,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Estilos().corpoColor(context, tamanho: 'p'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        CurrencyInputFormatter()
      ],
      validator: valida
          ? (value) => multiValidacoes(validacoes: [
                () => preenchimentoObrigatorio(input: value, message: null),
                () => valorMinimo(input: value)
              ])
          : null,
      onChanged: (value) {
        debugPrint(controle.text);
      },
    );
  }

  decimal(
    context, {
    required TextEditingController controle,
    required String label,
    required bool valida,
    required TextEditingController tipoM,
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
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        DecimalInputFormatter(),
        LengthLimitingTextInputFormatter(7)
      ],
      onChanged: (value) {
        debugPrint(controle.text);
      },
    );
  }
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

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    double value = double.parse(newValue.text);
    final formatter = NumberFormat.decimalPatternDigits(decimalDigits: 3);
    String newText = formatter.format(value * 0.001);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
