// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Equipment extends Equatable {
  final String id;
  final String name;
  final String description;
  final String price;
  final String weight;
  final DateTime createdAt;
  final String createdBy;
  final String sheetId;

  const Equipment({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.weight,
    required this.createdAt,
    required this.createdBy,
    required this.sheetId,
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

  Equipment copyWith({
    String? id,
    String? name,
    String? description,
    String? price,
    String? weight,
    DateTime? createdAt,
    String? createdBy,
    String? sheetId,
  }) {
    return Equipment(
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

  factory Equipment.fromMap(Map<String, dynamic> map) {
    return Equipment(
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

  factory Equipment.fromJson(String source) => Equipment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
