import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/core/icons/rpg_icons.dart';
import 'package:repege/core/widgets/card_title.dart';
import 'package:repege/core/widgets/text_form_field_bottom_sheet.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';

class EquipmentsPage extends StatelessWidget {
  const EquipmentsPage(this.sheet, {super.key});

  final SheetModel sheet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Equipamento'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
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
          ),
          Expanded(
            child: CardTitle(
              title: 'Equipamentos',
              icon: InkWell(
                child: const Icon(Icons.add),
                onTap: () {},
              ),
              child: Expanded(
                child: ListView.builder(
                  itemCount: [].length,
                  itemBuilder: (context, index) {
                    final equipment = [][index];
                    return ListTile(
                      title: Text(equipment.name),
                      trailing: Text('${equipment.price} | ${equipment.weight}'),
                      subtitle: Text(
                        equipment.description,
                        maxLines: 1,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      minLeadingWidth: 20,
                      leading: const SizedBox(
                        width: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Rpg.shield, size: 25, color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
