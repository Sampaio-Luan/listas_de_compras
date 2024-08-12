import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../mixins/validations_mixin.dart';
import '../../models/item_padrao.module.dart';
import '../../repositories/categorias_repository.dart';
import '../../repositories/itens_padrao_repository.dart';
import '../../theme/estilos.dart';

import 'campos_formulario.dart';
import 'categoria_dropmenu.dart';

class FormItemPadrao extends StatefulWidget {
  final ItemPadraoModel? itemPadrao;

  const FormItemPadrao({super.key, required this.itemPadrao});

  @override
  State<FormItemPadrao> createState() => _FormItemPadraoState();
}

class _FormItemPadraoState extends State<FormItemPadrao> with ValidacoesMixin {
  TextEditingController nomeItemPadrao = TextEditingController();
  TextEditingController categoriaItemPadrao = TextEditingController();

  final formKeyItemPadrao = GlobalKey<FormState>();
  bool autoValidar = false;
  CamposFormulario cf = CamposFormulario();

  @override
  void initState() {
    super.initState();
    if (widget.itemPadrao != null) {
      nomeItemPadrao.text = widget.itemPadrao!.nome;
      categoriaItemPadrao.text = widget.itemPadrao!.idCategoria.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemPadraoR = context.watch<ItensPadraoRepository>();
    final categoriaR = context.watch<CategoriasRepository>();
    return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        title: Text(
          widget.itemPadrao == null
              ? 'Cadastrar Item Padrão'
              : 'Editar Item Padrão',
          style: Estilos().tituloColor(context, tamanho: 'm'),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: formKeyItemPadrao,
              autovalidateMode: autoValidar
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                cf.linha(context,
                    controle: nomeItemPadrao,
                    label: 'Item',
                    qtdLinha: 1,
                    valida: true),
                const SizedBox(
                  height: 10,
                ),
                CategoriaDropMenu(
                  controle: categoriaItemPadrao,
                  isItemPadrao: false,
                ),
              ]),
            ),
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
              nomeItemPadrao.clear();
              categoriaItemPadrao.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text(
                widget.itemPadrao == null ? 'Cadastrar' : 'Salvar',
                style: Estilos().corpoColor(context, tamanho: 'm'),
              ),
              onPressed: () {
                setState(() {
                  autoValidar = true;
                });
                if (isValidado(
                        context: context,
                        formularioKey: formKeyItemPadrao,
                        mensagem: widget.itemPadrao == null
                            ? 'Cadastrado com sucesso !!!'
                            : 'Editado com sucesso !!!') ==
                    0) {
                  if (widget.itemPadrao == null) {
                    ItemPadraoModel itemP = ItemPadraoModel(
                      idItemPadrao: 0,
                      nome: nomeItemPadrao.text,
                      categoria: categoriaR.getCategorias
                          .firstWhere((element) =>
                              element.id == int.parse(categoriaItemPadrao.text))
                          .nome,
                      idCategoria: int.parse(categoriaItemPadrao.text),
                    );
                    itemPadraoR.criarItemPadrao(itemP);
                  } else {
                    widget.itemPadrao!.nome = nomeItemPadrao.text;
                    widget.itemPadrao!.idCategoria =
                        int.parse(categoriaItemPadrao.text);
                    widget.itemPadrao!.categoria = categoriaR.getCategorias
                        .firstWhere((element) =>
                            element.id == int.parse(categoriaItemPadrao.text))
                        .nome;
                         debugPrint(
                      'itemPadrao editado nome: ${widget.itemPadrao!.nome} id: ${widget.itemPadrao!.idItemPadrao} idCat: ${widget.itemPadrao!.idCategoria} cat: ${widget.itemPadrao!.categoria}');
                    itemPadraoR.editarItemPadrao(widget.itemPadrao!);
                  }
                 
                  nomeItemPadrao.clear();
                  categoriaItemPadrao.clear();
                  Navigator.of(context).pop();
                }
              }),
        ]);
  }
}
