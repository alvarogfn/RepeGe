import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/src/sheets/domain/entities/equipment.dart';

class EquipmentModel extends Equipment {
  const EquipmentModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.weight,
    required super.createdAt,
    required super.createdBy,
    required super.sheetId,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      price,
      weight,
      createdAt,
      createdBy,
      sheetId,
    ];
  }

  EquipmentModel copyWith({
    String? id,
    String? name,
    String? description,
    String? price,
    String? weight,
    DateTime? createdAt,
    String? createdBy,
    String? sheetId,
  }) {
    return EquipmentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      weight: weight ?? this.weight,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      sheetId: sheetId ?? this.sheetId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'weight': weight,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'createdBy': createdBy,
      'sheetId': sheetId,
    };
  }

  factory EquipmentModel.fromMap(Map<String, dynamic> map) {
    return EquipmentModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as String,
      weight: map['weight'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      createdBy: map['createdBy'] as String,
      sheetId: map['sheetId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EquipmentModel.fromJson(String source) => EquipmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  factory EquipmentModel.fromFirebase(DocumentSnapshot<Map> snapshot) {
    final map = snapshot.data()!;
    return EquipmentModel(
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      createdBy: map['createdBy'] as String,
      description: map['description'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] as String,
      sheetId: map['sheetId'] as String,
      weight: map['weight'] as String,
    );
  }
}
