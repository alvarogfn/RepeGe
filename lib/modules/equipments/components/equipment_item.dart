import 'package:flutter/material.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/modules/equipments/models/equipment.dart';

class EquipmentItem extends StatelessWidget {
  const EquipmentItem({
    super.key,
    required this.equipment,
  });

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(equipment.name),
      trailing: Text('${equipment.price}, ${equipment.weight}'),
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
          child: Icon(Rpg.potion, size: 25, color: Colors.black),
        ),
      ),
    );
  }
}
