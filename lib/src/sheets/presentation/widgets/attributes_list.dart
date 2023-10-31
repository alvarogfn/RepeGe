import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repege/core/utils/validations/required_validation.dart';
import 'package:repege/core/utils/validations/validations.dart';
import 'package:repege/src/sheets/presentation/widgets/attribute_form_field_bottom_sheet.dart';
import 'package:repege/src/sheets/domain/entities/attributes.dart';

const ptBRAttributes = [
  'Força',
  'Destreza',
  'Constituição',
  'Inteligência',
  'Sabedoria',
  'Carisma',
];

const ptBRAttributesMap = {
  'Força': 'strength',
  'Destreza': 'dextery',
  'Constituição': 'constitution',
  'Inteligência': 'intelligence',
  'Sabedoria': 'wisdom',
  'Carisma': 'charisma',
};

class AttributesList extends StatelessWidget {
  const AttributesList({
    super.key,
    required this.attributes,
    required this.onChange,
  });

  final Attributes attributes;

  final void Function(Attributes) onChange;

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        mainAxisExtent: 36,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: ptBRAttributes.map((attribute) {
        final attributeKey = ptBRAttributesMap[attribute]!;
        final attributeValue = attributes.toMap()[attributeKey];

        return AttributeFormFieldBottomSheet(
          title: ((attributeValue - 10) ~/ 2).toString(),
          label: attribute,
          value: attributeValue,
          onFieldSubmitted: (value) => onChange(attributes.copyWithMap({attributeKey: value})),
          validator: (value) => Validator.validateWith(value, [RequiredValidation()]),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
        );
      }).toList(),
    );
  }
}
