import 'dart:convert';

import 'package:repege/src/sheets/domain/entities/attributes.dart';

class AttributesModel extends Attributes {
  const AttributesModel({
    required super.strength,
    required super.dextery,
    required super.constitution,
    required super.intelligence,
    required super.wisdom,
    required super.charisma,
  });

  factory AttributesModel.empty() {
    return const AttributesModel(
      strength: 0,
      dextery: 0,
      constitution: 0,
      intelligence: 0,
      wisdom: 0,
      charisma: 0,
    );
  }

  AttributesModel copyWithMap(Map<String, dynamic> map) {
    return AttributesModel.fromMap(toMap()..addAll(map));
  }

  @override
  AttributesModel copyWith({
    int? strength,
    int? dextery,
    int? constitution,
    int? intelligence,
    int? wisdom,
    int? charisma,
  }) {
    return AttributesModel(
      strength: strength ?? this.strength,
      dextery: dextery ?? this.dextery,
      constitution: constitution ?? this.constitution,
      intelligence: intelligence ?? this.intelligence,
      wisdom: wisdom ?? this.wisdom,
      charisma: charisma ?? this.charisma,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'strength': strength,
      'dextery': dextery,
      'constitution': constitution,
      'intelligence': intelligence,
      'wisdom': wisdom,
      'charisma': charisma,
    };
  }

  factory AttributesModel.fromMap(Map<String, dynamic> map) {
    return AttributesModel(
      strength: map['strength'] as int,
      dextery: map['dextery'] as int,
      constitution: map['constitution'] as int,
      intelligence: map['intelligence'] as int,
      wisdom: map['wisdom'] as int,
      charisma: map['charisma'] as int,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory AttributesModel.fromJson(String source) =>
      AttributesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
