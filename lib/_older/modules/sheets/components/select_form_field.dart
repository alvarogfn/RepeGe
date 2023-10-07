import 'package:flutter/material.dart';

class SelectFormField<T> extends StatelessWidget {
  const SelectFormField({
    required this.label,
    required this.dropdownMenuEntries,
    this.controller,
    this.onSelected,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final void Function(T? item)? onSelected;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return DropdownMenu<T>(
        label: Text(label),
        controller: controller,
        onSelected: onSelected,
        width: constraints.maxWidth,
        dropdownMenuEntries: dropdownMenuEntries,
      );
    });
  }
}
