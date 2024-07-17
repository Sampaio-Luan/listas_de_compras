import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:listas_de_compras/pages/itens_page.dart';

import '../controllers/inicio_controller.dart';

class PrePage extends StatelessWidget {
  const PrePage({super.key});

  @override
  Widget build(BuildContext context) {
    final inicioApp = context.read<IniciarAppController>();
    return Scaffold(
      body: FutureBuilder(
          future: inicioApp.carregarPagina(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const ItensPage();
            }
          }),
    );
  }
}
