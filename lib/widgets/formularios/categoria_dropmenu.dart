import 'package:flutter/material.dart';

import 'package:multi_dropdown/multiselect_dropdown.dart';


class CategoriaDropMenu extends StatelessWidget {
  const CategoriaDropMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      searchEnabled: true,
      searchLabel: 'Pesquisar',
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
      },
      options: const <ValueItem>[
        ValueItem(label: 'Option 1', value: '1'),
        ValueItem(label: 'zef', value: '2'),
        ValueItem(label: 'porra 3', value: '3'),
        ValueItem(label: 'medo 4', value: '4'),
        ValueItem(label: 'caceta 5', value: '5'),
        ValueItem(label: 'dfe 6', value: '6'),
      ],
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
