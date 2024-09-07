import 'package:flutter/material.dart';

mixin ValidacoesMixin {
  String? preenchimentoObrigatorio(
      {required String? input, required String? message}) {
    if (input!.isEmpty) return message ?? 'Preenchimento obrigatório';
    return null;
  }

  String? quantidadeMinimaCaracteres(
      {required String? input,
      required int quantidade,
      required String? message}) {
    if (input!.length < quantidade) {
      return message ?? "Pelo menos $quantidade caracteres";
    }
    return null;
  }

  String? valorMinimo({required String? input}) {
    if (input != null) {
      if (input.length > 4) {
        input = input.replaceAll(RegExp(r'[^\d,]'), '').replaceAll(',', '.');
      } else {
        input = input.replaceAll(',', '.');
      }

      double valor = double.parse(input);

      if (valor <= 0) {
        return "Deve ser maior que 0";
      }
    }
    return null;
  }
}

String? multiValidacoes({required List<String? Function()> validacoes}) {
  for (final func in validacoes) {
    final validation = func();

    if (validation != null) {
      return validation;
    }
  }

  return null;
}

isValidado(
    {required BuildContext context,
    required GlobalKey<FormState> formularioKey,
    required String mensagem}) {
  if (formularioKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,

        content: Text(
          mensagem,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.brightness == Brightness.light
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        duration: const Duration(seconds: 3), // Defina o tempo desejado
      ),
    );
    return 0;
  }
}
