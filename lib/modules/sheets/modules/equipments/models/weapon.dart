import 'package:repege/helpers/parse_string.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment_types.dart';

class Weapon extends Equipment {
  late final String kind;
  late final String damage;

  Weapon({
    super.type = EquipmentTypes.weapon,
    required this.kind,
    required this.damage,
    required super.description,
    required super.ref,
    required super.id,
    required super.createdAt,
    required super.name,
    required super.price,
    required super.weight,
  });

  static Weapon fromMap(Map<String, dynamic> data) {
    return Weapon(
      kind: parseString(data['kind']),
      damage: parseString(data['damage']),
      description: parseString(data['description']),
      ref: data['ref'],
      id: parseString(data['id']),
      createdAt: data['createdAt'],
      name: parseString(data['name']),
      price: parseString(data['price']),
      weight: parseString(data['weight']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'kind': '',
      'damage': '',
      'description': '',
      'ref': '',
      'id': '',
      'createdAt': '',
      'name': '',
      'price': '',
      'weight': '',
    };
  }
}
