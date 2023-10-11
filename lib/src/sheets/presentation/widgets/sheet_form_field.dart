import 'dart:async';

import 'package:flutter/material.dart';

class SheetFormField extends StatefulWidget {
  const SheetFormField({
    required this.label,
    required this.initialValue,
    required this.onSubmit,
    this.isNumeric = false,
    this.small = false,
    this.isInsideRow = false,
    this.textAlign = TextAlign.left,
    this.helperText,
    super.key,
  });

  final bool isInsideRow;
  final bool small;
  final bool isNumeric;
  final String? helperText;
  final TextAlign textAlign;
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

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  void makeReadOnly() {
    if (!focusNode.hasFocus) {
      setState(() => readOnly = true);
    }
  }

  void makeWritable() {
    setState(() => readOnly = false);
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

  IconButton? get suffixIcon {
    if (widget.small) return null;

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
    if (widget.isInsideRow) {
      return Expanded(child: field());
    }
    return field();
  }

  Widget field() {
    return GestureDetector(
      onDoubleTap: makeWritable,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: widget.label,
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          helperText: widget.helperText,
        ),
        focusNode: focusNode,
        expands: false,
        readOnly: readOnly,
        textAlign: widget.textAlign,
        onFieldSubmitted: (_) => onSubmit(),
        initialValue: widget.initialValue,
        keyboardType: TextInputType.number,
        onTapOutside: (_) => makeReadOnly(),
        validator: (value) {
          if (!widget.isNumeric) return '';
          if (value == null || value.isEmpty) return '';
          try {
            int.parse(value);
            return '';
          } catch (_) {
            return 'Esse campo é somente númerico.';
          }
        },
        onChanged: (newValue) => setState(() => value = newValue),
      ),
    );
  }
}
