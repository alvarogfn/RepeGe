import 'package:flutter/material.dart';

class ObscureTextField extends StatefulWidget {
  const ObscureTextField({
    super.key,
    required this.label,
    required this.controller,
    this.textInputAction,
    this.validator,
    this.margin,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;
  final TextInputAction? textInputAction;
  final EdgeInsets? margin;

  @override
  State<ObscureTextField> createState() => _ObscureTextFieldState();
}

class _ObscureTextFieldState extends State<ObscureTextField> {
  bool _isObscure = true;

  void _toggleObscurity() {
    setState(() => _isObscure = !_isObscure);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: Focus(
            canRequestFocus: false,
            descendantsAreFocusable: false,
            child: IconButton(
              onPressed: _toggleObscurity,
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
        textInputAction: widget.textInputAction,
        obscureText: _isObscure,
        keyboardType: _isObscure ? TextInputType.visiblePassword : TextInputType.text,
        controller: widget.controller,
        validator: widget.validator,
      ),
    );
  }
}
