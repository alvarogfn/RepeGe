import 'package:flutter/material.dart';

class SelectFormField extends StatefulWidget {
  const SelectFormField({
    required this.items,
    required this.onChanged,
    required this.label,
    super.key,
  });

  final List items;
  final void Function(String?) onChanged;
  final String label;

  @override
  State<SelectFormField> createState() => _SelectFormFieldState();
}

class _SelectFormFieldState extends State<SelectFormField> {
  String? selectedItem;

  final FocusNode _inputFocus = FocusNode();

  List<DropdownMenuItem> get dropdownItems {
    final widgets = widget.items.map((item) {
      return DropdownMenuItem(
        value: item,
        child: Text(item.toString()),
      );
    }).toList();

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: dropdownItems,
      onChanged: (value) {
        setState(() => selectedItem = value);
        _inputFocus.requestFocus();
        widget.onChanged(value);
      },
      value: selectedItem,
      decoration: const InputDecoration(
        labelText: "Tipo",
      ),
    );
  }
}
