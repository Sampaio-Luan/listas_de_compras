import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../repositories/itens_padrao_repository.dart';
import '../theme/estilos.dart';
import '../widgets/formularios/form_item_padrao.dart';
import '../widgets/opcoes_modificacao.dart';

class ItensPadraoPage extends StatefulWidget {
  const ItensPadraoPage({super.key});

  @override
  State<ItensPadraoPage> createState() => _ItensPadraoPageState();
}

class _ItensPadraoPageState extends State<ItensPadraoPage> {
  @override
  Widget build(BuildContext context) {
    final itemP = context.watch<ItensPadraoRepository>();

    return Scaffold(
      appBar: AppBar(
          title: const Text('Itens Padrao'),
          centerTitle: true,
          backgroundColor:
              Theme.of(context).colorScheme.brightness == Brightness.light
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primaryContainer,
          foregroundColor:
              Theme.of(context).colorScheme.brightness == Brightness.light
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onPrimaryContainer,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) =>
                        const FormItemPadrao(itemPadrao: null));
              },
              icon: Icon(
                PhosphorIconsDuotone.listPlus,
                color:
                    Theme.of(context).colorScheme.brightness == Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ]),
      body: Column(children: [
        itemP.getItensPadrao.isEmpty
            ? const Center(child: Text('Nenhum item encontrado'))
            : Expanded(
                child: ListView.separated(
                 // shrinkWrap: true,
                  itemCount: itemP.getItensPadrao.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      leading: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.primary.withAlpha(40),
                        child: Text(itemP.getItensPadrao[index].nome[0]),
                      ),
                      title: Text(
                        itemP.getItensPadrao[index].nome,
                        style: Estilos().tituloColor(context, tamanho: 'p'),
                      ),
                      subtitle: Text(
                        '# ${itemP.getItensPadrao[index].categoria}',
                        style: Estilos().sutil(context, tamanho: 14),
                        
                      ),
                      trailing: OpcoesModificacao(itemPadrao: itemP.getItensPadrao[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 0,
                      thickness: 0.5,
                    ); // Adiciona uma linha separadora entre os itens
                  },
                ),
              )
      ]),
      
    );
  }
}
