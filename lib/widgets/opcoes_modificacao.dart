import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../controllers/listas_controller.dart';
import '../models/categoria.module.dart';
import '../models/historico.module.dart';
import '../models/item_padrao.module.dart';
import '../models/lista.module.dart';
import '../preferencias_usuario.dart';
import '../repositories/categorias_repository.dart';
import '../repositories/historico_repository.dart';
import '../repositories/itens_historico_repository.dart';
import '../repositories/itens_padrao_repository.dart';
import '../theme/estilos.dart';

import 'feedback/avisos.dart';
import 'formularios/form_categoria.dart';
import 'formularios/form_historico.dart';
import 'formularios/form_item_padrao.dart';
import 'formularios/formulario_lista.dart';

class OpcoesModificacao extends StatefulWidget {
  final ListaModel? lista;

  final CategoriaModel? categoria;
  final ItemPadraoModel? itemPadrao;
  final HistoricoModel? historico;

  const OpcoesModificacao({
    super.key,
    this.lista,
    this.categoria,
    this.itemPadrao,
    this.historico,
  });

  @override
  State<OpcoesModificacao> createState() => _OpcoesModificacaoState();
}

class _OpcoesModificacaoState extends State<OpcoesModificacao> {
  late ListaModel lista;
  late CategoriaModel categoria;
  late ItemPadraoModel itemPadrao;
  late HistoricoModel historico;
  final Avisos aviso = Avisos();

  @override
  void initState() {
    if (widget.lista != null) {
      lista = widget.lista!;
    } else if (widget.categoria != null) {
      categoria = widget.categoria!;
    } else if (widget.itemPadrao != null) {
      itemPadrao = widget.itemPadrao!;
    } else {
      historico = widget.historico!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listaController = context.watch<ListasController>();

    final itensController = context.read<ItensController>();
    final itemPadraoR = context.watch<ItensPadraoRepository>();
    final categoriaR = context.watch<CategoriasRepository>();
    final preferencias = context.watch<PreferenciasUsuarioShared>();
    final historicoR = context.watch<HistoricoRepository>();
    final itemHR = context.watch<ItensHistoricoRepository>();
    return PopupMenuButton<dynamic>(
      padding: const EdgeInsets.all(0),
      icon: Icon(
        PhosphorIconsRegular.pencil,
        color: Theme.of(context).colorScheme.primary,
      ),
      position: PopupMenuPosition.under,
      constraints: BoxConstraints.tightFor(
          width: MediaQuery.of(context).size.width * 0.3),
      elevation: 1,
      itemBuilder: (context) => [
        PopupMenuItem(
          child: _label(context, label: 'Editar'),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  if (widget.lista != null) {
                    return FormularioLista(lista: lista);
                  } else if (widget.categoria != null) {
                    return FormularioCategoria(categoria: categoria);
                  } else if (widget.itemPadrao != null) {
                    return FormItemPadrao(itemPadrao: itemPadrao);
                  } else {
                    return FormHistorico(historico: historico);
                  }
                });
          },
        ),
        PopupMenuItem(
          child: _label(context, label: 'Excluir'),
          onTap: () async {
            final confirmacao = await aviso.informativo(
              context,
              widget.categoria != null
                  ? 'Certeza que deseja excluir esse categoria? Todos os itens das listas e itens padrão que pertençam a ela serão movidos para "Sem Categorias", esse ação não poderá ser desfeita.'
                  : 'Certeza que deseja excluir? Essa ação não pode ser desfeita.',
            );

            if (confirmacao) {
              if (widget.historico != null) {
                historicoR.excluirHistorico(historico, itemHR);
              } else if (widget.lista != null) {
                await listaController.excluirLista(widget.lista!);
                int i = listaController.listas.last.id;

                itensController.iniciarController(
                  idLista: listaController.listas.last.id,
                  nomeLista: listaController.listas.last.nome,
                );
                preferencias.setUltimaListaVisitada(i);
              } else if (widget.categoria != null) {
                categoriaR.excluirCategorias(
                  categoria,
                  itensController,
                  itemPadraoR,
                );
              } else if (widget.itemPadrao != null) {
                itemPadraoR.excluirItemPadrao(itemPadrao);
              } else {
                historicoR.excluirHistorico(historico, itemHR);
              }
            }
          },
        ),
      ],
    );
  }

  _label(context, {required String label}) {
    Map<String, Widget> labels = {
      'Editar': Icon(
        PhosphorIconsRegular.clipboardText,
        color: Theme.of(context).colorScheme.primary,
        size: 22,
      ),
      'Excluir': Icon(
        PhosphorIconsRegular.trash,
        color: Theme.of(context).colorScheme.primary,
        size: 22,
      ),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.length <= 6 ? '$label ' : label,
          style: Estilos().corpoColor(context, tamanho: 'p'),
        ),
        const SizedBox(width: 10),
        labels[label]!,
      ],
    );
  }
}
