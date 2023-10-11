import 'package:flutter/material.dart';

class SheetDropdownMenu<T> extends StatelessWidget {
  const SheetDropdownMenu({
    required this.onSelected,
    required this.items,
    required this.labelText,
    required this.initialSelection,
    required this.builder,
    this.margin = const EdgeInsets.symmetric(vertical: 7.5),
    super.key,
  });

  final List<T> items;
  final EdgeInsets margin;
  final String labelText;
  final Function(T?)? onSelected;
  final T? initialSelection;
  final DropdownMenuEntry<T> Function(T) builder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: LayoutBuilder(builder: (context, constraints) {
        return DropdownMenu<T>(
          width: constraints.maxWidth,
          enableSearch: false,
          onSelected: onSelected,
          label: Text(labelText),
          initialSelection: initialSelection,
          dropdownMenuEntries: items.map(builder).toList(),
        );
      }),
    );
  }
}
