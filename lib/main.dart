import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../controllers/listas_controller.dart';
import '../repositories/listas_repository.dart';
import 'repositories/itens_repository.dart';

import 'main_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ItensController()),
        ChangeNotifierProvider(create: (context) => ItensRepository()),
        ChangeNotifierProvider(create: (context) => ListasController()),
        ChangeNotifierProvider(create: (context) => ListasRepository()),
      ],
      child: const MainApp(),
    ),
  );
}
