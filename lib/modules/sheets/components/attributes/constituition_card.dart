import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/components/sheet_form_field.dart';
import 'package:repege/modules/sheets/models/attributes.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class ConstituitionCard extends StatelessWidget {
  const ConstituitionCard({
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
              label: 'Constituição',
              initialValue: attributes.constitution.value.toString(),
              onSubmit: (constitutionValue) => sheet.ref.update({
                'attributes.constitution.value': constitutionValue,
              }),
            ),
          ],
        ),
      ),
    );
  }
}
