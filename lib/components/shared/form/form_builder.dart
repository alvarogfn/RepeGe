import 'package:flutter/material.dart';
import 'package:repege/components/shared/form/checkbox_form_field.dart';
import 'package:repege/components/shared/form/form_title.dart';
import 'package:repege/components/shared/form/select_form_field.dart';
import 'package:repege/models/utils/field.dart';
import 'package:repege/utils/validations/required_validation.dart';
import 'package:repege/utils/validations/validations.dart';

class FormBuilder extends StatefulWidget {
  const FormBuilder({
    required this.title,
    required this.fields,
    required this.submitLabel,
    this.onChanged,
    super.key,
  });

  final String title;
  final String submitLabel;
  final List<Field> fields;
  final void Function(Map<String, Object?>)? onChanged;

  @override
  State<FormBuilder> createState() => _FormFieldBuilderState();
}

class _FormFieldBuilderState extends State<FormBuilder> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, Object?> _formData = {};

  handleSubmit() {
    final currentState = _formKey.currentState;
    if (currentState == null) return;

    currentState.save();

    final isValid = currentState.validate();
    if (!isValid) return;
  }

  _updateValue(String propertyKey, Object? value) {
    _formData[propertyKey] = value;
    if (widget.onChanged != null) widget.onChanged!(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormTitle(
            title: widget.title,
            padding: const EdgeInsets.only(top: 20),
          ),
          ...widget.fields.map((field) {
            if (field is FieldSelect) {
              return SelectFormField(
                items: field.options,
                onChanged: (value) {
                  _updateValue(field.propertyKey, value);
                },
                label: field.label,
              );
            } else if (field is FieldCheckbox) {
              return CheckboxFormField(
                label: field.label,
                options: field.options,
                onChanged: (value) {
                  _updateValue(field.propertyKey, value);
                },
              );
            } else if (field is FieldText) {
              return TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(labelText: field.label),
                initialValue: field.value,
                maxLines: field.lines,
                onChanged: (value) {
                  _updateValue(field.propertyKey, value);
                },
                validator: field.mandatory
                    ? (value) => Validator.validateWith(value, [
                          RequiredValidation(),
                        ])
                    : null,
                textInputAction: field.inputAction,
                keyboardType: field.keyboardType,
              );
            }
          }).map((input) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: input,
            );
          }),
        ],
      ),
    );
  }
}
