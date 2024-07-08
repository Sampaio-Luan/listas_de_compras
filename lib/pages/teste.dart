import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/item.module.dart';
import '../repositories/itens_repository.dart';
import '../widgets/layout_item.dart';

class Teste extends StatelessWidget {
  
  const Teste({super.key});

  @override
  Widget build(BuildContext context) {
    final itemR = context.read<ItensRepository>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teste"),
      ),
      body: FutureBuilder(
          future: itemR.recuperarItens(3),
          builder:
              (BuildContext context, AsyncSnapshot<List<ItemModel>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return LayoutItem(item: snapshot.data![index]);
              },
            );
          }),
    );
  }
}
