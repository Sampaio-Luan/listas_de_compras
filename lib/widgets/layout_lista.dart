import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../models/lista.module.dart';
import '../pages/itens_page.dart';
import '../theme/estilos.dart';

import 'opcoes_modificacao.dart';

class LayoutLista extends StatefulWidget {
  final ListaModel lista;
  const LayoutLista({super.key, required this.lista});

  @override
  State<LayoutLista> createState() => _LayoutListaState();
}

class _LayoutListaState extends State<LayoutLista> {
  late ListaModel lista;
  final fomatoData = DateFormat.yMd('pt_BR');

  @override
  void initState() {
    super.initState();
    lista = widget.lista;
  }

  @override
  Widget build(BuildContext context) {
   
    return Card.outlined(
      elevation: 0,
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 00, top: 15, bottom: 5),
        child: Column(children: [
          Expanded(
            flex: 3,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItensPage(
                      lista: lista,
                    ),
                  ),
                );
              },
              child: Expanded(
                flex: 3,
                child: Row(children: [
                  Expanded(
                    child: Container(
                      child: _icone(context, nomeIcone: lista.icone),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lista.descricao,
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: Estilos().sutil(context, tamanho: 14),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              fomatoData.format(DateTime.parse(lista.criacao)),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: Estilos().sutil(context, tamanho: 14),
                            )
                          ]),
                    ),
                  )
                ]),
              ),
            ),
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(lista.nome.toUpperCase(),
                        style: Estilos().tituloColor(context, tamanho: 'p'),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false),
                  ),
                  OpcoesModificacao(lista: lista),
                ]),
          )
        ]),
      ),
    );
  }

  _icone(context, {required String nomeIcone}) {
    const double tamanho = 50;
    Map<String, Widget> icone = {
      'sacola': Icon(
        PhosphorIconsRegular.bag,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'carrinho': Icon(
        PhosphorIconsRegular.shoppingCart,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'cesta': Icon(
        PhosphorIconsRegular.basket,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'vitrine': Icon(
        PhosphorIconsRegular.storefront,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'boleto': Icon(
        PhosphorIconsRegular.barcode,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'cedula': Icon(
        PhosphorIconsRegular.moneyWavy,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'moedas': Icon(
        PhosphorIconsRegular.coins,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'carteira': Icon(
        PhosphorIconsRegular.wallet,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'cofrinho': Icon(
        PhosphorIconsRegular.piggyBank,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
    };
    return icone[nomeIcone];
  }
}
