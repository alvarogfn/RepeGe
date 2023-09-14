import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/sheets/components/bag_form.dart';
import 'package:repege/modules/sheets/models/bag.dart';
import 'package:repege/modules/equipments/components/equipment_list.dart';
import 'package:repege/modules/equipments/services/equipments.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class SheetEquipmentScreen extends StatelessWidget {
  const SheetEquipmentScreen({required this.sheet, super.key});

  final Sheet sheet;

  DocumentReference get ref => sheet.ref;
  Bag get bag => sheet.bag;
  Equipments get equipments => sheet.equipments;

  Future<void> createEquipment(BuildContext context) async {
    final equipment = await context.pushNamed<Map<String, dynamic>>(
      RoutesName.equipmentsForm.name,
    );

    if (equipment == null) return;

    return equipments.addEquipmentFromMap(equipment);
  }

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
          BagForm(bag: bag, ref: ref),
          Flexible(
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Equipamentos',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => createEquipment(context),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: EquipmentList(
                      equipments: sheet.equipments,
                      sheet: sheet,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
