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

  String? multiValidacoes({required List<String? Function()> validacoes}) {
    for (final func in validacoes) {
      final validation = func();

      if (validation != null) {
        return validation;
      }
    }

    return null;
  }

  isValidado({
    required BuildContext context,
    required GlobalKey<FormState> formularioKey,
  }) {
    if (formularioKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,

          content: const Text(
            "Salvo com sucesso !!!",
            style: TextStyle(fontSize: 16),
          ),
          duration: const Duration(seconds: 3), // Defina o tempo desejado
        ),
      );
      return 0;
    }
  }
}
