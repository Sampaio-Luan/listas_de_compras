import 'package:flutter/material.dart';

import 'package:listas_de_compras/pages/lista_compras_page.dart';



class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
 
  final List myTiles = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
  ];

  void updateMyTiles(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      final String tile = myTiles.removeAt(oldIndex);

      myTiles.insert(newIndex, tile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Re-Orderable ListView")),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: ReorderableListView(
              padding: const EdgeInsets.all(10),
              children: [
                for (final tile in myTiles)
                  Padding(
                    key: ValueKey(tile),
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey[200],
                      child: ListTile(
                        title: Text(tile.toString()),
                      ),
                    ),
                  ),
              ],
              onReorder: (oldIndex, newIndex) {
                updateMyTiles(oldIndex, newIndex);
              },
            ),
          ),
          const Center(child: CircularProgressIndicator()),
          Expanded(
            child: TextButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ListasDeComprasPage(),
                  ),
                );
              },
              child: const Text('Criar Lista'),
            ),
          ),
        ],
      ),
    );
  }

  
}
