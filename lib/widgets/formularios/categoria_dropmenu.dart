import 'package:flutter/material.dart';

import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../repositories/categorias_repository.dart';

class CategoriaDropMenu extends StatelessWidget {
  TextEditingController controle = TextEditingController();
   CategoriaDropMenu({required this.controle,super.key});
   final MultiSelectController _controller = MultiSelectController();

  @override
  Widget build(BuildContext context) {
    final categoriaR = context.watch<CategoriasRepository>();
    List<ValueItem> opcoes = [];
    opcoes.add(const ValueItem(label: 'Todos', value: 0));
    for (var element in categoriaR.getCategorias) {
      opcoes.add(ValueItem(label: element.nome, value: element.id));
    }
   // _controller.value= opcoes[0].value;
    return MultiSelectDropDown(
      //searchEnabled: true,
      //searchLabel: 'Pesquisar',
      selectedOptions: [opcoes[int.parse(controle.text)]],
      controller: _controller,
      hintPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      fieldBackgroundColor: Colors.transparent,
      inputDecoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      showChipInSingleSelectMode: true,
      dropdownMargin: 0,
      clearIcon: null,
      onOptionSelected: (options) {
        
        debugPrint(options.toString());
        controle.text = options[0].value.toString();
        debugPrint('controle: ${controle.text}');
      },
      options: opcoes,
      selectionType: SelectionType.single,
      dropdownHeight: 150,
      optionTextStyle: const TextStyle(fontSize: 14),
      selectedOptionIcon: const Icon(Icons.check_circle),
      hint: 'Categoria',
      dropdownBackgroundColor: Theme.of(context).colorScheme.background,
      optionsBackgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
