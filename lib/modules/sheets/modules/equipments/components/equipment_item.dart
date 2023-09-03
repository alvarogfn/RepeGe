import 'package:flutter/material.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/modules/sheets/modules/equipments/models/armor.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment.dart';
import 'package:repege/modules/sheets/modules/equipments/models/weapon.dart';

class EquipmentItem extends StatelessWidget {
  const EquipmentItem(this.equipment, {super.key});

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    if (equipment is Weapon) {
      final Weapon weapon = equipment as Weapon;
      return ListTile(
        title: Row(children: [const Icon(Rpg.bat_sword), Text(weapon.name)]),
        trailing: Text(weapon.price),
        subtitle: Text('${weapon.description}, ${weapon.weight}.'),
        leading: Text(weapon.damage),
      );
    }

    if (equipment is Armor) {
      final Armor armor = equipment as Armor;

      return ListTile(
        title: Row(children: [const Icon(Rpg.shield), Text(armor.name)]),
        trailing: Text(armor.price),
        subtitle: Text(armor.description),
        leading: Text(armor.weight),
      );
    }

    return ListTile(
      title: Row(children: [const Icon(Rpg.potion), Text(equipment.name)]),
      trailing: Text(equipment.price),
      subtitle: Text(equipment.description),
      leading: Text(equipment.weight),
    );
  }
}
