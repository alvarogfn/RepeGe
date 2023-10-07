import 'package:flutter/material.dart';

class UsernameTextField extends StatefulWidget {
  const UsernameTextField({
    required this.label,
    required this.controller,
    this.textInputAction,
    this.validator,
    this.margin,
    super.key,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;
  final TextInputAction? textInputAction;
  final EdgeInsets? margin;

  @override
  State<UsernameTextField> createState() => _UsernameTextFieldState();
}

class _UsernameTextFieldState extends State<UsernameTextField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: widget.label,
        ),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.name,
        controller: widget.controller,
        validator: widget.validator,
      ),
    );
  }
}
