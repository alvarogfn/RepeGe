import 'package:flutter/material.dart';

class SheetField extends StatelessWidget {
  const SheetField({
    required this.label,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        textInputAction: textInputAction,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigátorio';
          }
          return null;
        },
      ),
    );
  }
}
