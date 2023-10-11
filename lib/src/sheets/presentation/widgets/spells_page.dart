import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/core/widgets/card_title.dart';
import 'package:repege/core/widgets/text_form_field_bottom_sheet.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';

class SpellsPage extends StatelessWidget {
  const SpellsPage(this.sheet, {super.key});

  final SheetModel sheet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Magias'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
            title: 'Atributos',
            child: Builder(builder: (context) {
              update(SheetModel data) => context.read<SheetUpdateCubit>().updateSheet(
                    id: sheet.id,
                    newData: data.toMap(),
                  );

              return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 50,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TextFormFieldBottomSheet(
                    label: 'Bonus de Ataque',
                    value: sheet.attackBonus.toString(),
                    onFieldSubmitted: (value) => update(sheet.copyWith(attackBonus: int.tryParse(value) ?? 0)),
                  ),
                  TextFormFieldBottomSheet(
                    label: 'Hab. de Conjuração',
                    value: sheet.castingHability.toString(),
                    onFieldSubmitted: (value) => update(sheet.copyWith(castingHability: int.tryParse(value) ?? 0)),
                  ),
                  TextFormFieldBottomSheet(
                    label: 'Res. Mágica',
                    value: sheet.magicResistance.toString(),
                    onFieldSubmitted: (value) => update(sheet.copyWith(magicResistance: int.tryParse(value) ?? 0)),
                  ),
                ],
              );
            }),
          ),
          Expanded(
            child: CardTitle(
              title: 'Magias',
              icon: PopupMenuButton(
                child: const Icon(Icons.more_vert),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: const Text('Escrever Magia'),
                      onTap: () async {
                        // final data = await context.pushNamed<Map<String, dynamic>>(Routes.spellsForm.name);
                        // if (data == null) return;
                        // service.add(data);
                      },
                    ),
                  ];
                },
              ),
              child: Expanded(
                child: ListView.builder(
                  itemCount: [].length,
                  itemBuilder: (context, index) {
                    return Text(index.toString());
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
