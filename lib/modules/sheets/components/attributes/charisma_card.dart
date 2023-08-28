import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/components/sheet_form_checkbox.dart';
import 'package:repege/modules/sheets/components/sheet_form_field.dart';
import 'package:repege/modules/sheets/models/attributes.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class CharismaCard extends StatelessWidget {
  const CharismaCard({
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
              label: 'Carisma',
              initialValue: attributes.charisma.value.toString(),
              onSubmit: (charismaValue) => sheet.ref.update({
                'attributes.charisma.value': charismaValue,
              }),
            ),
            Wrap(
              spacing: 20,
              children: [
                SheetFormCheckBox(
                  labelText: 'Enganação',
                  value: attributes.charisma.deception,
                  onChanged: (deception) => sheet.ref.update(
                    {'attributes.charisma.deception': deception},
                  ),
                ),
                SheetFormCheckBox(
                  labelText: 'Intimidação',
                  value: attributes.charisma.intimidation,
                  onChanged: (intimidation) => sheet.ref.update(
                    {'attributes.charisma.intimidation': intimidation},
                  ),
                ),
                SheetFormCheckBox(
                  labelText: 'Atuação',
                  value: attributes.charisma.performance,
                  onChanged: (performance) => sheet.ref.update(
                    {'attributes.charisma.performance': performance},
                  ),
                ),
                SheetFormCheckBox(
                  labelText: 'Persuasão',
                  value: attributes.charisma.persuasion,
                  onChanged: (persuasion) => sheet.ref.update(
                    {'attributes.charisma.persuasion': persuasion},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
