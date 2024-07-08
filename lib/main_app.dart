import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'package:listas_de_compras/pages/abertura_page.dart';
import 'package:listas_de_compras/pages/apagar.dart';
import 'package:listas_de_compras/pages/lista_compras_page.dart';
import 'package:listas_de_compras/pages/principal_page.dart';
import 'package:listas_de_compras/theme/theme.dart';
import 'package:listas_de_compras/utils/util.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Balsamiq Sans", "Pridi");
    MaterialTheme theme = MaterialTheme(textTheme);

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
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      initialRoute: 'apagar',
      routes: {
        'principal': (context) => const PrincipalPage(),
        'listas': (context) => const ListasDeComprasPage(),
        
        'abertura': (context) => const AberturaPage(),
        'apagar': (context) =>
            const MyHomePage(title: 'Flutter Demo Home Page'),
      },
    );
  }
}


