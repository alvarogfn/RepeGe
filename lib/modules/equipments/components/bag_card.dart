import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/components/text_form_field_bottom_sheet.dart';
import 'package:repege/modules/sheet/sheet_service.dart';
import 'package:repege/modules/equipments/models/bag.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class BagCard extends StatefulWidget {
  const BagCard({super.key});

  @override
  State<BagCard> createState() => _BagCardState();
}

class _BagCardState extends State<BagCard> {
  Bag _bag = Bag();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sheet = context.watch<Sheet>();
    _bag = sheet.bag;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Text(
              'Bolsa',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: Consumer<SheetService>(
                builder: (context, service, child) {
                  return GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 40,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      TextFormFieldBottomSheet(
                        label: 'Cobre',
                        value: _bag.copper.toString(),
                        onChanged: (value) => _bag.copper = int.tryParse(value) ?? 0,
                        onFieldSubmitted: (_) => service.update(_bag),
                      ),
                      TextFormFieldBottomSheet(
                        label: 'Prata',
                        value: _bag.silver.toString(),
                        onChanged: (value) => _bag.silver = int.tryParse(value) ?? 0,
                        onFieldSubmitted: (_) => service.update(_bag),
                      ),
                      TextFormFieldBottomSheet(
                        label: 'Gold',
                        value: _bag.gold.toString(),
                        onChanged: (value) => _bag.gold = int.tryParse(value) ?? 0,
                        onFieldSubmitted: (_) => service.update(_bag),
                      ),
                      TextFormFieldBottomSheet(
                        label: 'Platinum',
                        value: _bag.platinum.toString(),
                        onChanged: (value) => _bag.platinum = int.tryParse(value) ?? 0,
                        onFieldSubmitted: (_) => service.update(_bag),
                      ),
                      TextFormFieldBottomSheet(
                        label: 'Electro',
                        value: _bag.electrum.toString(),
                        onChanged: (value) => _bag.electrum = int.tryParse(value) ?? 0,
                        onFieldSubmitted: (_) => service.update(_bag),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
