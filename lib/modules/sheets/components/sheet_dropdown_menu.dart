import 'package:flutter/material.dart';

class SheetDropdownMenu<T> extends StatefulWidget {
  const SheetDropdownMenu({
    required this.onSelected,
    required this.items,
    required this.labelText,
    required this.initialSelection,
    required this.builder,
    super.key,
  });

  final List<T> items;
  final String labelText;
  final Function(T?)? onSelected;
  final T? initialSelection;
  final DropdownMenuEntry<T> Function(T) builder;

  @override
  State<SheetDropdownMenu<T>> createState() => _SheetDropdownMenuState<T>();
}

class _SheetDropdownMenuState<T> extends State<SheetDropdownMenu<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      enableSearch: false,
      onSelected: widget.onSelected,
      label: Text(widget.labelText),
      initialSelection: widget.initialSelection,
      dropdownMenuEntries:
          widget.items.map<DropdownMenuEntry<T>>(widget.builder).toList(),
    );
  }
}
