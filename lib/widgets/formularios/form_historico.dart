import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../mixins/validations_mixin.dart';
import '../../models/historico.module.dart';
import '../../repositories/historico_repository.dart';
import '../../theme/estilos.dart';

import 'campos_formulario.dart';

class FormHistorico extends StatefulWidget {
  final HistoricoModel? historico;

  const FormHistorico({super.key, required this.historico});

  @override
  State<FormHistorico> createState() => _FormHistoricoState();
}

class _FormHistoricoState extends State<FormHistorico> with ValidacoesMixin {
  TextEditingController tituloHistorico = TextEditingController();
  TextEditingController descricaoHistorico = TextEditingController();
  TextEditingController dataHistorico = TextEditingController();

  final formKeyHistorico = GlobalKey<FormState>();
  bool autoValidar = false;

  CamposFormulario cf = CamposFormulario();

  @override
  void initState() {
    super.initState();
    if (widget.historico != null) {
      tituloHistorico.text = widget.historico!.titulo;
      dataHistorico.text = widget.historico!.data;
      descricaoHistorico.text = widget.historico!.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    final historicosR = context.read<HistoricoRepository>();
    return AlertDialog(
        title: Text(
          'Criar Histórico',
          style: Estilos().tituloColor(context, tamanho: 'm'),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: formKeyHistorico,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                cf.linha(
                  context,
                  controle: tituloHistorico,
                  label: 'Título',
                  qtdLinha: 1,
                  valida: true,
                ),
                const SizedBox(height: 10),
                cf.data(
                  context,
                  controle: dataHistorico,
                  label: 'Data',
                  valida: true,
                ),
                const SizedBox(height: 10),
                cf.linha(
                  context,
                  controle: descricaoHistorico,
                  label: 'Descrição',
                  qtdLinha: 3,
                  valida: false,
                ),
              ]),
            ),
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
              tituloHistorico.clear();
              dataHistorico.clear();
              descricaoHistorico.clear();
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
                        formularioKey: formKeyHistorico,
                        mensagem: widget.historico == null
                            ? 'Salvo com sucesso !!!'
                            : 'Editado com sucesso !!!') ==
                    0) {
                  if (widget.historico == null) {
                    HistoricoModel historico = HistoricoModel(
                        id: 0,
                        data: dataHistorico.text,
                        titulo: tituloHistorico.text,
                        descricao: descricaoHistorico.text);
                    historicosR.criarHistorico(historico);
                  } else {
                    widget.historico!.data = dataHistorico.text;
                    widget.historico!.titulo = tituloHistorico.text;
                    widget.historico!.descricao = descricaoHistorico.text;
                    historicosR.editarHistorico(widget.historico!);
                  }

                  tituloHistorico.clear();
                  dataHistorico.clear();
                  descricaoHistorico.clear();
                  Navigator.of(context).pop();
                }
              }),
        ]);
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length >= newValue.text.length) {
      // Fix for backspace bug
      return newValue;
    }
    final dateText = _addSeparators(newValue.text, '/');
    return newValue.copyWith(
      text: dateText,
      selection: updateCursorPosition(dateText),
    );
  }

  String _addSeparators(String value, String separator) {
    value = value.replaceAll('/', '');
    final buffer = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      buffer.write(value[i]);
      if (i == 1 || i == 3) {
        buffer.write(separator);
      }
    }
    return buffer.toString();
  }

  TextSelection updateCursorPosition(String text) {
    final cursorPosition = text.length;
    return TextSelection.collapsed(offset: cursorPosition);
  }
}
