import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

import '../../mixins/validations_mixin.dart';
import '../../theme/estilos.dart';

class CamposFormulario with ValidacoesMixin {
  final cPadding = const EdgeInsets.symmetric(vertical: 2, horizontal: 15);
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
        contentPadding: cPadding,
        hintText: qtdLinha == 2 ? 'Por exemplo "Marca x ou y"' : null,
        hintStyle: Estilos().sutil(context, tamanho: 15),
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

  linhaItem(
    context, {
    required TextEditingController controle,
  }) {
    return TextFormField(
        controller: controle,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          hintText: 'Digite o nome do item',
          hintStyle: Estilos().sutil(context, tamanho: 15),
          labelText: 'Item',
          labelStyle: Estilos().corpoColor(context, tamanho: 'p'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        validator: (value) =>
            preenchimentoObrigatorio(input: value, message: null));
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
        contentPadding: cPadding,
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
        contentPadding: cPadding,
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
    return TextFormField(
      controller: controle,
      decoration: InputDecoration(
        contentPadding: cPadding,
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

  data(
    context, {
    required TextEditingController controle,
    required String label,
    required bool valida,
  }) {
    return TextFormField(
      controller: controle,
      readOnly: true,
      onTap: () => _selectDate(context, controle),
      decoration: InputDecoration(
        contentPadding: cPadding,
        hintStyle: Estilos().sutil(context, tamanho: 15),
        labelText: label,
        labelStyle: Estilos().corpoColor(context, tamanho: 'p'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: valida
          ? (value) => preenchimentoObrigatorio(input: value, message: null)
          : null,
    );
  }

  DateTime _startDate = DateTime.now();
  Future<void> _selectDate(
      BuildContext context, TextEditingController controle) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now().add(const Duration(days: 0)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      _startDate = picked;

      controle.text = DateFormat.yMd('pt_BR').format(picked).toString();
    }
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
