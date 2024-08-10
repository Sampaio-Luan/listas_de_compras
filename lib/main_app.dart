import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../theme/theme.dart';
import '../utils/util.dart';

import 'pages/categorias_page.dart';
import 'pages/historico_page.dart';
import 'pages/itens_padrao_page.dart';
import 'pages/pre_page.dart';
import 'preferencias_usuario.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Balsamiq Sans", "Pridi");
    MaterialTheme theme = MaterialTheme(textTheme);
    final preferencias = context.watch<PreferenciasUsuarioShared>();

    Intl.defaultLocale = 'pt_BR';

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: preferencias.temaEscuro ? theme.verde() : theme.light(),
      initialRoute: 'itens_page',
      routes: {
        'itens_page': (context) => const PrePage(),
        'categorias_page': (context) => const CategoriasPage(),
        'historico_page': (context) => const HistoricoPage(),
        'itens_padrao_page': (context) => const ItensPadraoPage(),
      },
    );
  }
}
