import 'package:flutter/material.dart';

class Prioridades{
  final Map<String, int> prioridades = {
    'Alta': 0,
    'Média': 1,
    'Baixa': 2,
    'Neutra': 3,
  };

  final Map<int, Color> prioridadeColor = {
    0: Colors.red,
    1: Colors.orange,
    2: Colors.green,
    3: Colors.blue,
  };

  String nomePrioridade(int valor){
    return prioridades.keys.elementAt(prioridades.values.toList().indexOf(valor));
  }
}
