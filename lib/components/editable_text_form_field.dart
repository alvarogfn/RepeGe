import 'package:flutter/material.dart';

class EditableTextFormField extends StatefulWidget {
  const EditableTextFormField({
    super.key,
    this.initialValue,
    this.label,
    this.maxLines = 1,
    this.onSaved,
    this.onChanged,
    this.border,
    this.margin,
    this.hintText = '.....',
  });
  final String? initialValue;
  final String? label;
  final String? hintText;
  final int? maxLines;
  final EdgeInsets? margin;
  final InputBorder? border;
  final void Function(String value)? onChanged;
  final void Function(String? value)? onSaved;
  @override
  State<EditableTextFormField> createState() => _EditableTextFormFieldState();
}

class _EditableTextFormFieldState extends State<EditableTextFormField> {
  bool _readOnly = true;
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();

  void handleEdit() {
    FocusScope.of(context).requestFocus(focusNode);
    setState(() => _readOnly = false);
  }

  void handleSave() {
    _formKey.currentState?.save();
    setState(() => _readOnly = true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Form(
        key: _formKey,
        child: TextFormField(
          readOnly: _readOnly,
          initialValue: widget.initialValue,
          onChanged: widget.onChanged,
          maxLines: widget.maxLines,
          focusNode: focusNode,
          onSaved: widget.onSaved,
          onFieldSubmitted: (_) => handleSave(),
          onTapOutside: (_) {
            setState(() => _readOnly = true);
            _formKey.currentState?.reset();
          },
          decoration: InputDecoration(
            labelText: widget.label,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: widget.hintText,
            hintStyle: const TextStyle(fontStyle: FontStyle.italic),
            suffixIcon: GestureDetector(
              onTap: _readOnly ? handleEdit : handleSave,
              child: Icon(_readOnly ? Icons.edit : Icons.save),
            ),
            border: widget.border,
          ),
        ),
      ),
    );
  }
}
