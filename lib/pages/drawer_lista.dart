import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import 'package:listas_de_compras/controllers/listas_controller.dart';

import '../preferencias_usuario.dart';
import '../theme/estilos.dart';
import '../widgets/formulario_lista.dart';
import '../widgets/n_layout_lista.dart';

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(0),
        ),
      ),
      //width: MediaQuery.of(context).size.width * 0.6,
      elevation: 0,

      child: Column(children: [
        Expanded(
          flex: 2,
          child: Container(
            constraints: const BoxConstraints.expand(),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 8),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.primary.withAlpha(70),
                        radius: 20,
                        child: IconButton(
                          onPressed: () {
                            preferencias.mudarTema();
                          },
                          icon: preferencias.temaEscuro
                              ? const Icon(
                                  PhosphorIconsRegular.lightbulbFilament,
                                  size: 24)
                              : const Icon(PhosphorIconsRegular.lightbulb,
                                  size: 24, color: Colors.black54),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
        Expanded(
          flex: 12,
          child: Consumer<ListasController>(
              builder: (context, controleLista, child) {
            return ListView.separated(
                itemCount: controleLista.listas.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 0, thickness: 0.5);
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
        Expanded(
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const FormularioLista(
                      lista: null,
                    );
                  });
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(PhosphorIconsFill.clipboardText,
                  color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 12),
              Text('Criar nova lista',
                  style: Estilos().tituloColor(context, tamanho: 'p')),
            ]),
          ),
        ),
      ]),
    );
  }
}
