import 'dart:convert';

import 'package:repege/src/spells/domain/entities/spell.dart';

class SpellModel extends Spell {
  const SpellModel({
    required super.isPrepared,
    required super.material,
    required super.somatic,
    required super.verbal,
    required super.createdAt,
    required super.createdBy,
    required super.level,
    required super.castingTime,
    required super.description,
    required super.duration,
    required super.effectType,
    required super.id,
    required super.materials,
    required super.name,
    required super.range,
    required super.type,
    required super.sheetId,
  });

  @override
  SpellModel copyWith({
    bool? isPrepared,
    bool? material,
    bool? somatic,
    bool? verbal,
    DateTime? createdAt,
    String? createdBy,
    String? sheetId,
    int? level,
    String? castingTime,
    String? description,
    String? duration,
    String? effectType,
    String? id,
    String? materials,
    String? name,
    String? range,
    String? type,
  }) {
    return SpellModel(
      isPrepared: isPrepared ?? this.isPrepared,
      material: material ?? this.material,
      somatic: somatic ?? this.somatic,
      verbal: verbal ?? this.verbal,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      sheetId: sheetId ?? this.sheetId,
      level: level ?? this.level,
      castingTime: castingTime ?? this.castingTime,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      effectType: effectType ?? this.effectType,
      id: id ?? this.id,
      materials: materials ?? this.materials,
      name: name ?? this.name,
      range: range ?? this.range,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isPrepared': isPrepared,
      'material': material,
      'somatic': somatic,
      'verbal': verbal,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'createdBy': createdBy,
      'sheetId': sheetId,
      'level': level,
      'castingTime': castingTime,
      'description': description,
      'duration': duration,
      'effectType': effectType,
      'id': id,
      'materials': materials,
      'name': name,
      'range': range,
      'type': type,
    };
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  factory SpellModel.fromMap(Map<String, dynamic> map) {
    return SpellModel(
      isPrepared: map['isPrepared'] as bool,
      material: map['material'] as bool,
      somatic: map['somatic'] as bool,
      verbal: map['verbal'] as bool,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      createdBy: map['createdBy'] as String,
      sheetId: map['sheetId'] as String,
      level: map['level'] as int,
      castingTime: map['castingTime'] as String,
      description: map['description'] as String,
      duration: map['duration'] as String,
      effectType: map['effectType'] as String,
      id: map['id'] as String,
      materials: map['materials'] as String,
      name: map['name'] as String,
      range: map['range'] as String,
      type: map['type'] as String,
    );
  }

  factory SpellModel.fromJson(String source) => SpellModel.fromMap(json.decode(source) as Map<String, dynamic>);
  factory SpellModel.empty() {
    return SpellModel(
      castingTime: '',
      createdAt: DateTime.now(),
      createdBy: '',
      description: '',
      duration: '',
      effectType: '',
      id: '',
      isPrepared: false,
      level: 0,
      material: false,
      materials: '',
      name: '',
      range: '',
      sheetId: '',
      somatic: false,
      type: '',
      verbal: false,
    );
  }
}
