import 'package:flutter/material.dart';

import 'package:expandable_text/expandable_text.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
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
    final itensController = context.read<ItensController>();

    return Card.outlined(
      elevation: 0,
      color: Theme.of(context).colorScheme.onBackground.withAlpha(50),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 00, top: 15, bottom: 5),
        child: Column(children: [
          Expanded(
            flex: 4,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                itensController.iniciarController(idLista: lista.id);
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
              
                child: Row(children: [
                  Expanded(
                    child: Container(
                      child: _icone(context, nomeIcone: lista.icone),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: Text(
                                fomatoData.format(DateTime.parse(lista.criacao)),
                                
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: Estilos().sutil(context, tamanho: 10),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: ExpandableText(
                                lista.descricao,
                                style: const TextStyle(leadingDistribution: TextLeadingDistribution.proportional),
                                expandText: 'Mostrar +',
                                collapseText: 'Mostrar -',
                                maxLines: 2,
                                //linkColor: Colors.blue,
                              ),
                            ),
                            
                            
                            
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
