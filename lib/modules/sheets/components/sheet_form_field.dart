import 'dart:async';

import 'package:flutter/material.dart';

class SheetFormField extends StatefulWidget {
  const SheetFormField({
    required this.label,
    required this.initialValue,
    required this.onSubmit,
    this.helperText,
    super.key,
  });

  final String? helperText;
  final String label;
  final String initialValue;
  final Future<void> Function(String value) onSubmit;

  @override
  State<SheetFormField> createState() => _SheetFormFieldState();
}

class _SheetFormFieldState extends State<SheetFormField> {
  bool readOnly = true;
  String value = '';
  late FocusNode focusNode;

  void makeReadOnlyOnBlur() {
    if (!focusNode.hasFocus) {
      setState(() => readOnly = true);
    }
  }

  FutureOr<void> onSubmit() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (value == widget.initialValue) return;

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Salvando...'),
        ),
      );
      await widget.onSubmit(value);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Salvo.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível salvar.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    focusNode.addListener(makeReadOnlyOnBlur);
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.removeListener(makeReadOnlyOnBlur);
  }

  IconButton get suffixIcon {
    if (readOnly) {
      return IconButton(
        iconSize: 20,
        onPressed: () {
          setState(() => readOnly = false);
          FocusScope.of(context).requestFocus(focusNode);
        },
        icon: const Icon(Icons.edit),
      );
    }

    return IconButton(
      iconSize: 20,
      onPressed: () {
        onSubmit();
        setState(() => readOnly = false);
      },
      icon: const Icon(Icons.save),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.label,
        border: InputBorder.none,
        suffixIcon: suffixIcon,
        helperText: widget.helperText,
      ),
      focusNode: focusNode,
      expands: false,
      readOnly: readOnly,
      onFieldSubmitted: (_) => onSubmit(),
      initialValue: widget.initialValue,
      onChanged: (newValue) => setState(() => value = newValue),
    );
  }
}
