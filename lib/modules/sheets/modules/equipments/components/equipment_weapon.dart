import 'package:flutter/material.dart';
import 'package:repege/icons/rpg_icons.dart';
import 'package:repege/modules/sheets/modules/equipments/models/weapon.dart';

class EquipmentWeapon extends StatelessWidget {
  const EquipmentWeapon({
    super.key,
    required this.weapon,
  });

  final Weapon weapon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(weapon.name),
      trailing: Text(weapon.damage),
      subtitle: Text(
        '${weapon.description}, ${weapon.price}, ${weapon.weight}.',
        maxLines: 1,
        style: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
      minLeadingWidth: 20,
      leading: const SizedBox(
        width: 20,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(Rpg.axe, size: 25, color: Colors.black),
        ),
      ),
    );
  }
}
