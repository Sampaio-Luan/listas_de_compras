import 'dart:math';

import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../constants/const_strings_globais.dart';
import '../controllers/itens_controller.dart';
import '../models/categoria.module.dart';
import '../repositories/categorias_repository.dart';
import '../theme/estilos.dart';

class OpcoesFiltros extends StatelessWidget {
  final String itemOuLista;
  final TextEditingController filtroCategoria = TextEditingController();

  OpcoesFiltros({super.key, required this.itemOuLista});

  @override
  Widget build(BuildContext context) {
    final itemC = context.watch<ItensController>();
    final categoriasR = context.read<CategoriasRepository>();
    return PopupMenuButton<dynamic>(
        padding: const EdgeInsets.all(0),
        icon: const Icon(
          PhosphorIconsRegular.funnel,
        ),
        constraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width * 0.5),
        position: PopupMenuPosition.under,
        elevation: 1,
        itemBuilder: (context) => [
              PopupMenuItem(
                child: _label(context, label: kComprados),
                onTap: () {
                  if (itemOuLista == 'item') {
                    itemC.filtrarItens(tipoFiltro: 'check', valor: 1);
                  }
                },
              ),
              PopupMenuItem(
                child: _label(context, label: kAComprar),
                onTap: () {
                  if (itemOuLista == 'item') {
                    itemC.filtrarItens(tipoFiltro: 'check', valor: 0);
                  }
                },
              ),
              PopupMenuItem(
                child: _categorias(context, categoriasR, itemC),
                onTap: () {},
              ),
              PopupMenuItem(
                child: ExpansionTile(
                    title: Text(
                      'Prioridade',
                      style: Estilos().corpoColor(context, tamanho: 'p'),
                    ),
                    children: [
                      PopupMenuItem(
                          child: _label(context,
                              label: 'Alta', icone: kPrioridade),
                          onTap: () {
                            itemC.filtrarItens(
                                tipoFiltro: 'prioridade', valor: 0);
                          }),
                      PopupMenuItem(
                          child: _label(context,
                              label: 'Média', icone: kPrioridade),
                          onTap: () {
                            itemC.filtrarItens(
                                tipoFiltro: 'prioridade', valor: 1);
                          }),
                      PopupMenuItem(
                          child: _label(context,
                              label: 'Baixa', icone: kPrioridade),
                          onTap: () {
                            itemC.filtrarItens(
                                tipoFiltro: 'prioridade', valor: 2);
                          }),
                      PopupMenuItem(
                          child: _label(context,
                              label: 'Nula', icone: kPrioridade),
                          onTap: () {
                            itemC.filtrarItens(
                                tipoFiltro: 'prioridade', valor: 3);
                          }),
                    ]),
              ),
            ]);
  }

  _label(context, {required String label, String? icone}) {
    const double tamanho = 30;
    Map<String, Widget> labels = {
      kComprados: Icon(
        PhosphorIconsRegular.checkSquare,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      kAComprar: Icon(
        PhosphorIconsRegular.square,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      kTodos: Icon(
        PhosphorIconsRegular.listBullets,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      kPrioridade: Icon(
        PhosphorIconsRegular.ranking,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'Categoria': Icon(
        PhosphorIconsRegular.sparkle,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
      'Categoria2': Icon(
        PhosphorIconsRegular.stackPlus,
        color: Theme.of(context).colorScheme.primary,
        size: tamanho,
      ),
    };
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: Text(
          label,
          style: Estilos().corpoColor(context, tamanho: 'p'),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: icone == null ? labels[label] : labels[icone],
    );
  }

  _categorias(context, CategoriasRepository cat, ItensController itemCTRL) {
    List<CategoriaModel> categorias = cat.getCategorias;
    return PopupMenuButton<CategoriaModel>(
      constraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width * 0.6),
      child: _label(context, label: 'Categorias', icone: 'Categoria2'),
      itemBuilder: (BuildContext context) {
        return categorias.map<PopupMenuItem<CategoriaModel>>((value) {
          return PopupMenuItem<CategoriaModel>(
            value: value,
            child: _label(context, label: value.nome, icone: 'Categoria'),
          );
        }).toList();
      },
      onSelected: (CategoriaModel result) {
        debugPrint('${result.grau}');
        itemCTRL.filtrarItens(
            tipoFiltro: 'categoria', valor: result.id, categoriaR: cat);
        Navigator.of(context).pop();
      },
    );
  }
}
