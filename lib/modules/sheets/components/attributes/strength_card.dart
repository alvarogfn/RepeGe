import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/components/sheet_form_checkbox.dart';
import 'package:repege/modules/sheets/components/sheet_form_field.dart';
import 'package:repege/modules/sheets/models/attributes.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class StrengthCard extends StatelessWidget {
  const StrengthCard({
    super.key,
    required this.attributes,
    required this.sheet,
  });

  final Attributes attributes;
  final Sheet sheet;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SheetFormField(
              label: 'Força',
              initialValue: attributes.strength.value.toString(),
              onSubmit: (strengthValue) => sheet.ref.update({
                'attributes.strength.value': strengthValue,
              }),
            ),
            SheetFormCheckBox(
              labelText: 'Atletismo',
              value: attributes.strength.atletism,
              onChanged: (value) => sheet.ref.update(
                {'attributes.strength.atletism': value},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
