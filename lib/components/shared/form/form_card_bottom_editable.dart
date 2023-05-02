import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/components/shared/labeled_text.dart';
import 'package:repege/models/utils/field.dart';
import 'package:repege/utils/validations/required_validation.dart';
import 'package:repege/utils/validations/validations.dart';

class FormCardBottomEditable extends StatefulWidget {
  const FormCardBottomEditable({
    required this.title,
    required this.fields,
    this.onSaved,
    super.key,
  });

  final String title;
  final List<Field> fields;
  final void Function(Map<String, Object>)? onSaved;

  @override
  State<FormCardBottomEditable> createState() => _FormCardBottomEditableState();
}

class _FormCardBottomEditableState extends State<FormCardBottomEditable> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      child: const Icon(Icons.edit),
                      onTap: () {
                        _showModalBottomSheet(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.fields.map((field) {
                return LabeledText(field);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<Object, String>?> _showModalBottomSheet(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Map<String, String> formData = {};

    return showModalBottomSheet<Map<Object, String>?>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        ThemeData theme = Theme.of(context);
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: keyboardHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Editar ${widget.title}",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    ...widget.fields.map((field) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: field.label),
                          initialValue: field.value,
                          textInputAction: TextInputAction.next,
                          onSaved: (newValue) {
                            formData[field.propertyKey] = newValue!;
                          },
                          validator: (value) => Validator.validateWith(value, [
                            RequiredValidation(),
                          ]),
                        ),
                      );
                    }).toList(),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          formKey.currentState?.save();
                          final isValid = formKey.currentState?.validate();

                          if (isValid == true) {
                            context.pop(formData);
                          }
                        },
                        child: const Text("Modificar"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
