import 'package:flutter/material.dart';
import 'package:repege/icons/rpg_icons.dart';

enum EquipmentTypes {
  armor(translation: 'Armaduras', icon: Icon(Rpg.heavy_shield)),
  weapon(translation: 'Armas', icon: Icon(Rpg.axe)),
  item(translation: 'Itens', icon: Icon(Rpg.potion));

  const EquipmentTypes({
    required this.translation,
    required this.icon,
  });

  final String translation;
  final Icon icon;
}

EquipmentTypes equipmentTypesFromString(String value) {
  switch (value) {
    case 'armor':
      return EquipmentTypes.armor;
    case 'weapon':
      return EquipmentTypes.weapon;
    case 'item':
      return EquipmentTypes.item;
    default:
      throw Exception('This string is not valid!');
  }
}
