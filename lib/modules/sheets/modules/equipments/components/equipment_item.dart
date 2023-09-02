import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment.dart';

class EquipmentItem extends StatelessWidget {
  const EquipmentItem(this.equipment, {super.key});

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(equipment.title),
      trailing: Text(equipment.valuation),
      subtitle: Text(equipment.description),
    );
  }
}
