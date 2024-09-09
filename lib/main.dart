import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../controllers/listas_controller.dart';
import '../repositories/listas_repository.dart';

import 'controllers/inicio_controller.dart';
import 'main_app.dart';
import 'preferencias_usuario.dart';
import 'repositories/categorias_repository.dart';
import 'repositories/historico_repository.dart';
import 'repositories/itens_historico_repository.dart';
import 'repositories/itens_padrao_repository.dart';
import 'repositories/itens_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PreferenciasUsuarioShared(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (context) => ItensController()),
        ChangeNotifierProvider(create: (context) => ItensRepository()),
        ChangeNotifierProvider(create: (context) => ListasController()),
        ChangeNotifierProvider(create: (context) => ListasRepository()),
        ChangeNotifierProvider(
          create: (context) => IniciarAppController(
              listasController: context.read<ListasController>(),
              preferencias: context.read<PreferenciasUsuarioShared>(),
              itensController: context.read<ItensController>()),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (context) => ItensPadraoRepository()),
        ChangeNotifierProvider(create: (context) => HistoricoRepository()),
        ChangeNotifierProvider(
          create: (context) => CategoriasRepository(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (context) => ItensHistoricoRepository()),
      ],
      child: const MainApp(),
    ),
  );
}
