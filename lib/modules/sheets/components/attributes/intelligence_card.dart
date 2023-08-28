import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/components/sheet_form_checkbox.dart';
import 'package:repege/modules/sheets/components/sheet_form_field.dart';
import 'package:repege/modules/sheets/models/attributes.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class IntelligenceCard extends StatelessWidget {
  const IntelligenceCard({
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
              label: 'Inteligência',
              initialValue: attributes.intelligence.value.toString(),
              onSubmit: (intelligenceValue) => sheet.ref.update({
                'attributes.intelligence.value': intelligenceValue,
              }),
            ),
            Wrap(
              spacing: 20,
              children: [
                SheetFormCheckBox(
                  labelText: 'Arcanismo',
                  value: attributes.intelligence.arcana,
                  onChanged: (arcana) => sheet.ref.update(
                    {'attributes.intelligence.arcana': arcana},
                  ),
                ),
                SheetFormCheckBox(
                  labelText: 'História',
                  value: attributes.intelligence.history,
                  onChanged: (history) => sheet.ref.update(
                    {'attributes.intelligence.history': history},
                  ),
                ),
                SheetFormCheckBox(
                  labelText: 'Investigação',
                  value: attributes.intelligence.investigation,
                  onChanged: (investigation) => sheet.ref.update(
                    {'attributes.intelligence.investigation': investigation},
                  ),
                ),
                SheetFormCheckBox(
                  labelText: 'Natureza',
                  value: attributes.intelligence.nature,
                  onChanged: (nature) => sheet.ref.update(
                    {'attributes.intelligence.nature': nature},
                  ),
                ),
                SheetFormCheckBox(
                  labelText: 'Religião',
                  value: attributes.intelligence.religion,
                  onChanged: (religion) => sheet.ref.update(
                    {'attributes.intelligence.religion': religion},
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
