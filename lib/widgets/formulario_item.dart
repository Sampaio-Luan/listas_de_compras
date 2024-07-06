import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/item.module.dart';
import '../repositories/itens_repository.dart';
import '../theme/estilos.dart';

import 'campos_formulario.dart';

class FormularioItem extends StatefulWidget {
  final ItemModel? item;
  final int? idLista;

  const FormularioItem({super.key, this.item, this.idLista});

  @override
  State<FormularioItem> createState() => _FormularioItemState();
}

class _FormularioItemState extends State<FormularioItem> {
  TextEditingController nomeItem = TextEditingController();
  TextEditingController descricaoItem = TextEditingController();
  TextEditingController quantidadeItem = TextEditingController();
  TextEditingController precoItem = TextEditingController();
  GlobalKey formKeyItem = GlobalKey<FormState>();

  CamposFormulario cf = CamposFormulario();
  @override
  Widget build(BuildContext context) {
    final itensR = context.watch<ItensRepository>();
    return AlertDialog(
        title: Text(
          widget.item == null ? 'Cadastrar Item' : 'Editar Item',
          style: Estilos().tituloColor(context, tamanho: 'g'),
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKeyItem,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              cf.linha(
                context,
                controle: nomeItem,
                label: 'Item',
                qtdLinha: 1,
                valida: true,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: cf.linha(
                      context,
                      controle: quantidadeItem,
                      label: 'Quantidade',
                      qtdLinha: 1,
                      valida: true,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: cf.linha(
                      context,
                      controle: precoItem,
                      label: 'Preço',
                      qtdLinha: 1,
                      valida: true,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              cf.linha(
                context,
                controle: descricaoItem,
                label: 'Descrição',
                qtdLinha: 2,
                valida: true,
              ),
            ]),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            child: Text(
              'Cancelar',
              style: Estilos().corpoColor(context, tamanho: 'm'),
            ),
            onPressed: () {
              _resetTextController();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text(
                widget.item == null ? 'Cadastrar' : 'Salvar',
                style: Estilos().corpoColor(context, tamanho: 'm'),
              ),
              onPressed: () {
                if (widget.item == null) {
                  ItemModel i = ItemModel(
                    idItem: 0,
                    idLista: widget.idLista!,
                    nome: nomeItem.text,
                    descricao: descricaoItem.text,
                    quantidade: double.parse(quantidadeItem.text),
                    preco: double.parse(precoItem.text),
                    comprado: 0,
                    indice: 0,
                  );
                  itensR.inserirItem(i);
                } else {
                  widget.item!.nome = nomeItem.text;
                  widget.item!.quantidade = double.parse(quantidadeItem.text);
                  widget.item!.preco = double.parse(precoItem.text);
                  widget.item!.descricao = descricaoItem.text;
                  itensR.atualizarItem(widget.item!);
                }
                _resetTextController();
                Navigator.of(context).pop();
              }),
        ]);
  }

  _resetTextController() {
    nomeItem.clear();
    quantidadeItem.clear();
    precoItem.clear();
    descricaoItem.clear();
  }
}
