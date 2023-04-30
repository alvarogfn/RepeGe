import 'package:flutter/material.dart';

class SelectFormField extends StatefulWidget {
  const SelectFormField({
    required this.items,
    required this.onChanged,
    required this.label,
    this.onSaved,
    super.key,
  });

  final List items;
  final void Function(String?) onChanged;
  final String label;
  final void Function(String?)? onSaved;

  @override
  State<SelectFormField> createState() => _SelectFormFieldState();
}

class _SelectFormFieldState extends State<SelectFormField> {
  String? selectedItem;

  final FocusNode _inputFocus = FocusNode();

  List<DropdownMenuItem<String>> get dropdownItems {
    final widgets = widget.items.map((item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item.toString()),
      );
    }).toList();

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: dropdownItems,
      onChanged: (value) {
        setState(() => selectedItem = value);
        _inputFocus.requestFocus();
        widget.onChanged(value);
      },
      value: selectedItem,
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      onSaved: widget.onSaved,
    );
  }
}
