import 'package:flutter/material.dart';

class CategoriasPage extends StatelessWidget {
  const CategoriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Categorias')),
      body: const Center(child: Text('Categorias')),
    );
  }
}