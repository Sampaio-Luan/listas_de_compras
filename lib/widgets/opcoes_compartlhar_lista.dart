import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../theme/estilos.dart';

class OpcoesCompartilharLista extends StatefulWidget {
  const OpcoesCompartilharLista({super.key});

  @override
  State<OpcoesCompartilharLista> createState() =>
      _OpcoesCompartilharListaState();
}

class _OpcoesCompartilharListaState extends State<OpcoesCompartilharLista> {
  List<IconData> iconesOpcoes = [
    PhosphorIconsRegular.checkSquare,
    PhosphorIconsRegular.square,
    PhosphorIconsRegular.gridFour,
  ];

  List<IconData> iconesAtributos = [
    PhosphorIconsRegular.basket,
    PhosphorIconsRegular.money,
    PhosphorIconsRegular.listNumbers,
  ];
  List<String> titulos = ['Com check', 'Sem check', 'Todos'];
  List<String> atributos = ['Item', 'Preço', 'Quantidade'];

  int escolhido = 0;
  Map<String, List<String>> escolhas = {
    'Quais Itens': ['Sem check'],
    'Quais Propriedades': ['Item', 'Quantidade'],
  };
  @override
  Widget build(BuildContext context) {
    final itemC = context.watch<ItensController>();
    return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 1,
        title: Text(
          'Compartilhar itens da lista',
          style: Estilos().tituloColor(context, tamanho: 'm'),
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Row(children: [
            Expanded(
              child: Column(children: [
                Text(
                  'Itens:',
                  style: Estilos().sutil(context, tamanho: 14),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: ListView.builder(
                        itemCount: titulos.length,
                        itemBuilder: (context, index) {
                          return FilterChip(
                            padding: const EdgeInsets.all(1),
                            avatar: Icon(iconesOpcoes[index],
                                color: Theme.of(context).colorScheme.primary),
                            showCheckmark: false,
                            label: Text(titulos[index]),
                            selected: escolhas['Quais Itens']!
                                .contains(titulos[index]),
                            onSelected: (bool value) {
                              setState(() {
                                escolhas['Quais Itens']![0] = titulos[index];
                                debugPrint('Escolhidos $escolhas');
                              });
                            },
                          );
                        }),
                  ),
                ),
              ]),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Atributos:',
                    style: Estilos().sutil(context, tamanho: 14),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      child: ListView.builder(
                          itemCount: atributos.length,
                          itemBuilder: (context, index) {
                            return FilterChip(
                              padding: const EdgeInsets.all(1),
                              avatar: Icon(iconesAtributos[index],
                                  color: Theme.of(context).colorScheme.primary),
                              showCheckmark: false,
                              label: Text(atributos[index]),
                              selected: escolhas['Quais Propriedades']!
                                  .contains(atributos[index]),
                              onSelected: (bool value) {
                                if (index == 0) {
                                } else {
                                  setState(() {
                                    if (escolhas['Quais Propriedades']!
                                        .contains(atributos[index])) {
                                      escolhas['Quais Propriedades']!
                                          .remove(atributos[index]);
                                    } else {
                                      escolhas['Quais Propriedades']!
                                          .add(atributos[index]);
                                    }
                                  });
                                }
                                debugPrint('Escolhidos $escolhas');
                              },
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
        actions: [
          TextButton(
            style: ElevatedButton.styleFrom(
              elevation: 1,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancelar',
              style: Estilos().corpoColor(context, tamanho: 'm'),
            ),
          ),
          TextButton(
            style: ElevatedButton.styleFrom(
              elevation: 1,
            ),
            onPressed: () {
              itemC.compartilharSocial(escolhas);
              Navigator.pop(context);
            },
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(
                'Confirmar',
                style: Estilos().corpoColor(context, tamanho: 'm'),
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                PhosphorIconsLight.shareFat,
                color: Theme.of(context).colorScheme.primary,
              ),
            ]),
          ),
        ]);
  }
}
