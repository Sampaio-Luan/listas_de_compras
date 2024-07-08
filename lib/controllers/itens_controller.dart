import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/item.module.dart';

class ItensController extends ChangeNotifier {
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
  String get total => formatter.format(_total);
  double _total = 0;

  calculaTotal(List<ItemModel> itens) {
    double t = 0;
    for (var item in itens) {
      if (item.comprado == 1) {
        t += item.preco * item.quantidade;
      }
    }
    _total = t;
    notifyListeners();
  }
}
