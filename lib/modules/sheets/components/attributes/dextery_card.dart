import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/components/sheet_form_checkbox.dart';
import 'package:repege/modules/sheets/components/sheet_form_field.dart';
import 'package:repege/modules/sheets/models/attributes.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class DexteryCard extends StatelessWidget {
  const DexteryCard({
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
              label: 'Destreza',
              initialValue: attributes.dextery.value.toString(),
              onSubmit: (dexteryValue) => sheet.ref.update({
                'attributes.dextery.value': dexteryValue,
              }),
            ),
            Wrap(
              spacing: 20,
              children: [
                SheetFormCheckBox(
                  labelText: 'Prestidigitação',
                  value: attributes.dextery.sleightOfHand,
                  onChanged: (value) => sheet.ref.update(
                    {'attributes.dextery.sleightOfHand': value},
                  ),
                ),
                SheetFormCheckBox(
                  labelText: 'Furtividade',
                  value: attributes.dextery.stealth,
                  onChanged: (value) => sheet.ref.update(
                    {'attributes.dextery.stealth': value},
                  ),
                ),
                SheetFormCheckBox(
                  labelText: 'Acrobacia',
                  value: attributes.dextery.acrobatics,
                  onChanged: (value) => sheet.ref.update(
                    {'attributes.dextery.acrobatics': value},
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
