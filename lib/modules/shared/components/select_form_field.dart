import 'package:flutter/material.dart';

class Select<T> extends StatefulWidget {
  const Select({
    required this.items,
    required this.label,
    this.margin = const EdgeInsets.all(0),
    this.initialValue,
    this.validator,
    this.onSaved,
    this.onChanged,
    super.key,
  });

  final List<T> items;
  final EdgeInsets margin;
  final T? initialValue;
  final void Function(dynamic)? onChanged;
  final String label;
  final void Function(T?)? onSaved;
  final String? Function(T?)? validator;

  @override
  State<Select> createState() => _SelectFormFieldState();
}

class _SelectFormFieldState<T> extends State<Select<T>> {
  late T? selectedItem = widget.initialValue;

  List<DropdownMenuItem<T>> get dropdownItems {
    final widgets = widget.items.map((item) {
      return DropdownMenuItem<T>(
        value: item,
        child: Text(item.toString()),
      );
    }).toList();

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: DropdownButtonFormField<T>(
        items: dropdownItems,
        onChanged: widget.onChanged,
        validator: widget.validator,
        value: selectedItem,
        decoration: InputDecoration(
          labelText: widget.label,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onSaved: widget.onSaved,
      ),
    );
  }
}
