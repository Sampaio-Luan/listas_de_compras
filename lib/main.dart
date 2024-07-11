import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../controllers/listas_controller.dart';
import '../repositories/listas_repository.dart';

import 'main_app.dart';
import 'repositories/itens_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');

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
