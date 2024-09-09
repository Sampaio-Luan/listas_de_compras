import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:listas_de_compras/models/lista.module.dart';

import '../../controllers/itens_controller.dart';
import '../../controllers/listas_controller.dart';
import '../../mixins/validations_mixin.dart';
import '../../preferencias_usuario.dart';
import '../../theme/estilos.dart';

import 'campos_formulario.dart';

class FormularioLista extends StatefulWidget {
  final ListaModel? lista;
  const FormularioLista({
    super.key,
    this.lista,
  });

  @override
  State<FormularioLista> createState() => _FormularioListaState();
}

class _FormularioListaState extends State<FormularioLista>
    with ValidacoesMixin {
  TextEditingController nomeLista = TextEditingController();

  TextEditingController descricaoLista = TextEditingController();

  final formKeyLista = GlobalKey<FormState>();
  bool autoValidar = false;

  CamposFormulario cf = CamposFormulario();
  @override
  void initState() {
    super.initState();
    if (widget.lista != null) {
      nomeLista.text = widget.lista!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    final listasR = context.read<ListasController>();
    final preferencias = context.watch<PreferenciasUsuarioShared>();
    return AlertDialog(
        title: Text(
          'Criar Lista',
          style: Estilos().tituloColor(context, tamanho: 'm'),
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        content: SizedBox(
          //width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKeyLista,
            autovalidateMode: autoValidar
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              cf.linha(
                context,
                controle: nomeLista,
                label: 'Nome da Lista',
                qtdLinha: 1,
                valida: true,
              ),
            ]),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          TextButton(
            child: Text(
              'Cancelar',
              style: Estilos().corpoColor(context, tamanho: 'p'),
            ),
            onPressed: () {
              nomeLista.clear();
              descricaoLista.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text(
                'Salvar',
                style: Estilos().corpoColor(context, tamanho: 'p'),
              ),
              onPressed: () {
                setState(() {
                  autoValidar = true;
                });
                if (isValidado(
                        context: context,
                        formularioKey: formKeyLista,
                        mensagem: widget.lista == null
                            ? 'Salvo com sucesso !!!'
                            : 'Editado com sucesso !!!') ==
                    0) {
                  final itemC = context.read<ItensController>();
                  if (widget.lista == null) {
                    ListaModel lista = ListaModel(
                        id: 0,
                        nome: nomeLista.text,
                        criacao: DateTime.now().toString(),
                        indice: 0,
                        tema: 'padrao',
                        totalItens: 0,
                        totalComprados: 0);

                    listasR.inserirLista(lista, itemC, preferencias);
                  } else {
                    widget.lista!.nome = nomeLista.text;

                    listasR.atualizarLista(widget.lista!);
                    itemC.setNomeLista(nomeLista.text);
                  }

                  nomeLista.clear();
                  descricaoLista.clear();
                  Navigator.of(context).pop();
                }
              }),
        ]);
  }
}
