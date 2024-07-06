import 'package:flutter/material.dart';

import '../models/item.module.dart';

class ItensController extends ChangeNotifier {
  final List<ItemModel> _itens = [];
  List<ItemModel> get itensDaLista => _itens;


}
