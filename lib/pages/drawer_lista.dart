import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import 'package:listas_de_compras/controllers/listas_controller.dart';

import '../preferencias_usuario.dart';
import '../theme/estilos.dart';
import '../widgets/formularios/formulario_lista.dart';
import '../widgets/lista_layout.dart';

class DrawerListas extends StatefulWidget {
  const DrawerListas({super.key});

  @override
  State<DrawerListas> createState() => _DrawerListasState();
}

class _DrawerListasState extends State<DrawerListas> {
  final formatoData = DateFormat.yMMMMd('pt_BR');
  @override
  Widget build(BuildContext context) {
    final preferencias = context.read<PreferenciasUsuarioShared>();

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(0),
        ),
      ),
      //width: MediaQuery.of(context).size.width * 0.6,
      elevation: 0,

      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.17,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Minhas Listas',
                            style:
                                Estilos().tituloColor(context, tamanho: 'g')),
                        Text('Versão 1.0.0',
                            style: Estilos().sutil(context, tamanho: 12))
                      ]),
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withAlpha(70),
                    radius: 20,
                    child: IconButton(
                      onPressed: () {
                        preferencias.mudarTema();
                      },
                      icon: Theme.of(context).brightness == Brightness.dark
                          ? const Icon(PhosphorIconsFill.lamp, size: 24)
                          : Icon(
                              PhosphorIconsFill.lampPendant,
                              size: 24,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                    ),
                  )
                ]),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const FormularioLista(lista: null);
                  });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(children: [
                Icon(PhosphorIconsDuotone.notePencil,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 16),
                Text('Criar nova lista',
                    style: Estilos().tituloColor(context, tamanho: 'p')),
              ]),
            ),
          ),
        ),
        const Divider(
          height: 0,
          thickness: 0.5,
        ),
        Expanded(
          flex: 12,
          child: Consumer<ListasController>(
              builder: (context, controleLista, child) {
            return ListView.separated(
                padding: const EdgeInsets.all(0),
                itemCount: controleLista.listas.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 0, thickness: 0.3);
                },
                itemBuilder: (context, index) {
                  return NLayoutLista(lista: controleLista.listas[index]);
                });
          }),
        ),
        const Divider(
          height: 0,
          thickness: 0.5,
        ),
        _botaoDrawer(
          context,
          icone: PhosphorIconsDuotone.basket,
          titulo: 'Gerenciar itens',
          rota: 'itens_padrao_page',
        ),
        const Divider(
          height: 0,
          thickness: 0.5,
        ),
        _botaoDrawer(
          context,
          icone: PhosphorIconsDuotone.stackPlus,
          titulo: 'Gerenciar categorias',
          rota: 'categorias_page',
        ),
        const Divider(
          height: 0,
          thickness: 0.5,
        ),
        _botaoDrawer(
          context,
          icone: PhosphorIconsDuotone.clockCounterClockwise,
          titulo: 'Historico de compras',
          rota: 'historico_page',
        ),
        const Divider(
          height: 0,
          thickness: 0.5,
        ),
        _botaoDrawer(
          context,
          icone: PhosphorIconsDuotone.palette,
          titulo: 'Tema de cores',
          rota: 'tema-de-cores',
        ),
      ]),
    );
  }

  _botaoDrawer(context,
      {required String titulo, required IconData icone, required String rota}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(rota);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(children: [
            Icon(icone, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            Text(titulo, style: Estilos().tituloColor(context, tamanho: 'p')),
          ]),
        ),
      ),
    );
  }
}
