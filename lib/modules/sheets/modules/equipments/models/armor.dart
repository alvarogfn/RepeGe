import 'package:repege/helpers/parse_bool.dart';
import 'package:repege/helpers/parse_int.dart';
import 'package:repege/helpers/parse_string.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment_types.dart';

class Armor extends Equipment {
  final String kind;
  final String armorClass;
  final int minStrength;
  final bool isStealth;

  Armor({
    super.type = EquipmentTypes.armor,
    required super.id,
    required super.ref,
    required super.name,
    required super.description,
    required super.createdAt,
    required super.price,
    required super.weight,
    required this.kind,
    required this.armorClass,
    required this.minStrength,
    required this.isStealth,
  });

  static Armor fromMap(Map<String, dynamic> data) {
    return Armor(
      kind: parseString(data['kind']),
      armorClass: parseString(data['armorClass']),
      minStrength: parseInt(data['minStrength']),
      isStealth: parseBool(data['isStealth']),
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
      'kind': kind,
      'armorClass': armorClass,
      'minStrength': minStrength,
      'isStealth': isStealth,
      'description': description,
      'ref': ref,
      'id': id,
      'createdAt': createdAt,
      'name': name,
      'price': price,
      'weight': weight,
      'type': type.name,
    };
  }
}
