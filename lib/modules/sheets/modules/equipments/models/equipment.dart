import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment_types.dart';

class Equipment {
  final EquipmentTypes type;
  final DocumentReference<Equipment> ref;
  final String id;
  final String name;
  final String description;
  final String price;
  final String weight;
  final Timestamp createdAt;

  Equipment({
    required this.id,
    required this.ref,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.price,
    required this.weight,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ref': ref,
      'name': name,
      'description': description,
      'createdAt': createdAt,
      'price': price,
      'weight': weight,
      'type': type,
    };
  }
}
