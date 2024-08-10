import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/itens_controller.dart';
import '../controllers/listas_controller.dart';
import '../models/item.module.dart';
import '../repositories/itens_padrao_repository.dart';
import '../theme/estilos.dart';
import '../widgets/formularios/categoria_dropmenu.dart';

class EndDrawerItensPadrao extends StatelessWidget {
  final TextEditingController controlle = TextEditingController();
  EndDrawerItensPadrao({super.key});
  @override


  @override
  Widget build(BuildContext context) {
    if (controlle.text.isEmpty) {
      controlle.text = '0';
    }
    
    final itemPR = context.watch<ItensPadraoRepository>();
    final itemCControle = context.watch<ItensController>();
    final listaC = context.watch<ListasController>();
    List<String> nomes =
        itemCControle.itens.map((e) => e.nome.toLowerCase()).toList();

        
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(0),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.6,
      elevation: 0,
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width * 0.6,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Text(
              'Itens Padrao',
              style: Estilos().tituloColor(context, tamanho: 'g'),
            ),
          ),
        ),
        itemPR.getItensPadraoInterface.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CategoriaDropMenu(
                  controle: controlle,
                  isItemPadrao: true,
                ),
              ),
        Expanded(
          child: ListView.separated(
              itemCount: itemPR.getItensPadraoInterface.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                    height: 0,
                    thickness: 0.6,
                  ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 5.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itemPR.getItensPadraoInterface[index].nome,
                                  style: Estilos()
                                      .corpoColor(context, tamanho: 'm'),
                                  //overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '# ${itemPR.getItensPadraoInterface[index].categoria}',
                                  style: Estilos().sutil(context, tamanho: 12),
                                )
                              ]),
                        ),
                        nomes.contains(
                                itemPR.getItensPadraoInterface[index].nome.toLowerCase())
                            ? IconButton(
                                color: Colors.red,
                                onPressed: () {
                                  itemCControle.removerComEndDrawer(
                                      itemPR.getItensPadraoInterface[index].nome,
                                      listaC);
                                },
                                icon: const Icon(
                                  PhosphorIconsRegular.xCircle,
                                ),
                              )
                            : IconButton(
                                color: Theme.of(context).colorScheme.primary,
                                onPressed: () {
                                  ItemModel item = ItemModel(
                                    nome: itemPR.getItensPadraoInterface[index].nome,
                                    idLista: itemCControle.getIdLista,
                                    idItem: 0,
                                    descricao: '',
                                    quantidade: 1,
                                    medida: 'uni',
                                    preco: 0.0,
                                    prioridade: 3,
                                    comprado: 0,
                                    indice: 0,
                                    idCategoria: itemPR
                                        .getItensPadraoInterface[index].idCategoria,
                                  );
                                  itemCControle.adicionarItem(item, listaC);
                                },
                                icon: const Icon(
                                  PhosphorIconsRegular.plusCircle,
                                ),
                              ),
                      ]),
                );
              }),
        ),
      ]),
    );
  }
}
