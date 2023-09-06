import 'package:flutter/material.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/modules/sheets/modules/equipments/models/armor.dart';

class EquipmentArmor extends StatelessWidget {
  const EquipmentArmor({
    super.key,
    required this.armor,
  });

  final Armor armor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(armor.name),
      trailing: Text('${armor.price}, ${armor.weight}'),
      subtitle: Text(
        armor.description,
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
  }
}
