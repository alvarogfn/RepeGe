enum EquipmentTypes {
  armor(translation: 'Armaduras'),
  weapon(translation: 'Armas'),
  item(translation: 'Itens');

  const EquipmentTypes({
    required this.translation,
  });

  final String translation;
}

EquipmentTypes equipmentTypesFromString(String value) {
  switch (value) {
    case 'armor':
      return EquipmentTypes.armor;
    case 'weapon':
      return EquipmentTypes.item;
    case 'item':
      return EquipmentTypes.item;
    default:
      throw Exception('This string is not valid!');
  }
}
