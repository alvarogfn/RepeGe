import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/components/sheet_form_checkbox.dart';
import 'package:repege/modules/sheets/components/sheet_form_field.dart';
import 'package:repege/modules/sheets/models/attributes.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class WisdomCard extends StatelessWidget {
  const WisdomCard({
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
              label: 'Sabedoria',
              initialValue: attributes.wisdom.value.toString(),
              onSubmit: (wisdomValue) => sheet.ref.update({
                'attributes.wisdom.value': wisdomValue,
              }),
            ),
            Wrap(
              spacing: 20,
              children: [
                SheetFormCheckBox(
                  labelText: 'Intuição',
                  value: attributes.wisdom.insight,
                  onChanged: (insight) => sheet.ref.update(
                    {'attributes.wisdom.insight': insight},
                  ),
                ),
                SheetFormCheckBox(
                  labelText: 'Medicina',
                  value: attributes.wisdom.medicine,
                  onChanged: (medicine) => sheet.ref.update(
                    {'attributes.wisdom.medicine': medicine},
                  ),
                ),
                SheetFormCheckBox(
                  labelText: 'Percepção',
                  value: attributes.wisdom.perception,
                  onChanged: (perception) => sheet.ref.update(
                    {'attributes.wisdom.perception': perception},
                  ),
                ),
                SheetFormCheckBox(
                  labelText: 'Sobrevivência',
                  value: attributes.wisdom.survival,
                  onChanged: (survival) => sheet.ref.update(
                    {'attributes.wisdom.survival': survival},
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
