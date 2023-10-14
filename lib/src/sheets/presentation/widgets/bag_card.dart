import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/core/widgets/card_title.dart';
import 'package:repege/core/widgets/text_form_field_bottom_sheet.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';

class BagCard extends StatelessWidget {
  const BagCard(this.sheet, {super.key});

  final SheetModel sheet;

  @override
  Widget build(BuildContext context) {
    return CardTitle(
      title: 'Bolsa',
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 20,
          mainAxisExtent: 40,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: sheet.bagModel.toMap().entries.map((entry) {
          return TextFormFieldBottomSheet(
            label: entry.key,
            value: entry.value.toString(),
            onFieldSubmitted: (value) {
              context.read<SheetUpdateCubit>().updateBag(sheet: sheet, newData: {entry.key: entry.value});
            },
          );
        }).toList(),
      ),
    );
  }
}
