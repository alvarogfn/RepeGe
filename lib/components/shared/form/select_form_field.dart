import 'package:flutter/material.dart';

class SelectFormField extends StatefulWidget {
  const SelectFormField({
    required this.items,
    required this.label,
    this.validator,
    this.onSaved,
    this.onChanged,
    super.key,
  });

  final List items;
  final void Function(String?)? onChanged;
  final String label;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

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
        if (widget.onChanged != null) widget.onChanged!(value);
      },
      validator: widget.validator,
      value: selectedItem,
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: widget.onSaved,
    );
  }
}
