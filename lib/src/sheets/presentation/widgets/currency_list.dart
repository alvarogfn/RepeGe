import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repege/core/utils/validations/required_validation.dart';
import 'package:repege/core/utils/validations/validations.dart';
import 'package:repege/core/widgets/text_form_field_bottom_sheet.dart';
import 'package:repege/src/sheets/domain/entities/bag.dart';

const currencies = [
  'Cobre',
  'Prata',
  'Eletro',
  'Ouro',
  'Platina',
];

const currenciesMap = {
  'Cobre': 'copper',
  'Prata': 'silver',
  'Ouro': 'gold',
  'Eletro': 'electrum',
  'Platina': 'platinum',
};

class CurrencyList extends StatelessWidget {
  const CurrencyList({
    super.key,
    required this.bag,
    required this.onChange,
  });

  final Bag bag;

  final Function(Bag) onChange;

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 20,
        mainAxisExtent: 50,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: currencies.map((currency) {
        final currencyKey = currenciesMap[currency]!;

        return TextFormFieldBottomSheet(
          label: currency,
          value: bag.toMap()[currencyKey].toString(),
          onFieldSubmitted: (value) => onChange(bag.copyWithMap({currencyKey: int.parse(value)})),
          validator: (value) => Validator.validateWith(value, [
            RequiredValidation(),
          ]),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
        );
      }).toList(),
    );
  }
}
