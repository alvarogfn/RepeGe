import 'package:cloud_firestore/cloud_firestore.dart';

class Equipment {
  EquipmentTypes type;
  DocumentReference ref;
  String id;
  String name;
  String description;
  String price;
  String weight;
  Timestamp? createdAt;

  Equipment({
    required this.id,
    required this.ref,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.price,
    required this.weight,
    this.type = EquipmentTypes.item,
  });

  static Equipment fromMap(Map<String, dynamic> data) {
    return Equipment(
      description: parseString(data['description']),
      ref: data['ref'],
      id: parseString(data['id']),
      createdAt: data['createdAt'],
      name: parseString(data['name']),
      price: parseString(data['price']),
      weight: parseString(data['weight']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ref': ref,
      'name': name,
      'description': description,
      'createdAt': createdAt,
      'price': price,
      'weight': weight,
      'type': type.name,
    };
  }
}
