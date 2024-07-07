import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:listas_de_compras/models/lista.module.dart';

import '../mixins/validations_mixin.dart';
import '../repositories/listas_repository.dart';
import '../theme/estilos.dart';
import '../widgets/campos_formulario.dart';

class Formulario extends StatefulWidget {
  final ListaModel? lista;
  const Formulario({
    super.key,
    this.lista,
  });

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> with ValidacoesMixin {
  TextEditingController nomeLista = TextEditingController();

  TextEditingController descricaoLista = TextEditingController();

  final formKeyLista = GlobalKey<FormState>();

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
    final listasR = context.read<ListasRepository>();
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
                if (isValidado(context: context, formularioKey: formKeyLista) == 0) {
                  if (widget.lista == null) {
                    ListaModel l = ListaModel(
                        id: 0,
                        nome: nomeLista.text,
                        descricao: descricaoLista.text.isEmpty ? '' : descricaoLista.text,
                        criacao: DateTime.now().toString(),
                        indice: 0,
                        icone: 'sacola');

                    listasR.inserirLista(l);
                  } else {
                    widget.lista!.nome = nomeLista.text;
                    widget.lista!.descricao = descricaoLista.text;
                    listasR.atualizarLista(widget.lista!);
                  }
                  nomeLista.clear();
                  descricaoLista.clear();
                  Navigator.of(context).pop();
                }
              }),
        ]);
  }
}
