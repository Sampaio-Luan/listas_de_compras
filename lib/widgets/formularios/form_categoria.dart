import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../mixins/validations_mixin.dart';
import '../../models/categoria.module.dart';
import '../../repositories/categorias_repository.dart';
import '../../theme/estilos.dart';

import 'campos_formulario.dart';

class FormularioCategoria extends StatefulWidget with ValidacoesMixin {
  final CategoriaModel? categoria;

  FormularioCategoria({super.key, required this.categoria});

  @override
  State<FormularioCategoria> createState() => _FormularioCategoriaState();
}

class _FormularioCategoriaState extends State<FormularioCategoria> {
  TextEditingController tituloCategoria = TextEditingController();

  final formKeyCategoria = GlobalKey<FormState>();

  bool autoValidar = false;

  CamposFormulario cf = CamposFormulario();
  @override
  void initState() { 
    super.initState();
    if (widget.categoria != null) {
    tituloCategoria.text = widget.categoria!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriaR = context.watch<CategoriasRepository>();
    return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        title: Text(
          widget.categoria == null ? 'Cadastrar Categoria' : 'Editar Categoria',
          style: Estilos().tituloColor(context, tamanho: 'g'),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: formKeyCategoria,
              autovalidateMode: autoValidar
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: cf.linha(
                context,
                controle: tituloCategoria,
                label: 'Titulo da Categoria',
                qtdLinha: 1,
                valida: true,
              ),
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
              tituloCategoria.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text(
                widget.categoria == null ? 'Cadastrar' : 'Salvar',
                style: Estilos().corpoColor(context, tamanho: 'm'),
              ),
              onPressed: () {
                setState(() {
                  autoValidar = true;
                });
                if (isValidado(
                        context: context,
                        formularioKey: formKeyCategoria,
                        mensagem: widget.categoria == null
                            ? 'Cadastrado com sucesso !!!'
                            : 'Editado com sucesso !!!') ==
                    0) {
                  if (widget.categoria == null) {
                    CategoriaModel cat = CategoriaModel(
                      id: 0,
                      nome: tituloCategoria.text,
                      grau: categoriaR.getCategorias.length,
                    );
                    categoriaR.criarCategorias(cat);
                  } else {
                    widget.categoria!.nome = tituloCategoria.text;
                    categoriaR.editarCategorias([widget.categoria!]);
                  }
                  tituloCategoria.clear();
                  Navigator.of(context).pop();
                }
              }),
        ]);
  }
}
