import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:listas_de_compras/models/lista.module.dart';

import '../../controllers/itens_controller.dart';
import '../../controllers/listas_controller.dart';
import '../../mixins/validations_mixin.dart';
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
      descricaoLista.text = widget.lista!.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    final listasR = context.read<ListasController>();
    return AlertDialog(
        title: Text(
          'Criar Lista',
          style: Estilos().tituloColor(context, tamanho: 'g'),
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
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
              const SizedBox(
                height: 10,
              ),
              cf.linha(
                context,
                controle: descricaoLista,
                label: 'Descrição',
                qtdLinha: 2,
                valida: false,
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
              nomeLista.clear();
              descricaoLista.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text(
                'Salvar',
                style: Estilos().corpoColor(context, tamanho: 'm'),
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
                        descricao: descricaoLista.text.isEmpty
                            ? ''
                            : descricaoLista.text,
                        criacao: DateTime.now().toString(),
                        indice: 0,
                        icone: 'sacola',
                        tema: 'padrao',
                        totalItens: 0,
                        totalComprados: 0);

                    listasR.inserirLista(lista, itemC );
                  } else {

                    

                    widget.lista!.nome = nomeLista.text;
                    widget.lista!.descricao = descricaoLista.text;

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
