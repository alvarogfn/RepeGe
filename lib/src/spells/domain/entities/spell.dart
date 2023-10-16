// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Spell extends Equatable {
  final bool isPrepared;
  final bool material;
  final bool somatic;
  final bool verbal;
  final DateTime createdAt;
  final String createdBy;
  final String sheetId;
  final int level;
  final String castingTime;
  final String description;
  final String duration;
  final String effectType;
  final String id;
  final String materials;
  final String name;
  final String range;
  final String type;

  const Spell({
    required this.isPrepared,
    required this.material,
    required this.somatic,
    required this.verbal,
    required this.createdAt,
    required this.createdBy,
    required this.sheetId,
    required this.level,
    required this.castingTime,
    required this.description,
    required this.duration,
    required this.effectType,
    required this.id,
    required this.materials,
    required this.name,
    required this.range,
    required this.type,
  });

  @override
  List<Object> get props {
    return [
      isPrepared,
      material,
      somatic,
      verbal,
      createdAt,
      createdBy,
      sheetId,
      level,
      castingTime,
      description,
      duration,
      effectType,
      id,
      materials,
      name,
      range,
      type,
    ];
  }

  Spell copyWith({
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
    return Spell(
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

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;
}
