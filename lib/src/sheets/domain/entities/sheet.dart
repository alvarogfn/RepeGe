// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Sheet extends Equatable {
  final DateTime createdAt;
  final int armorClass;
  final int attackBonus;
  final int castingHability;
  final int characterLevel;
  final int currentHp;
  final int iniative;
  final int magicResistance;
  final int maxHp;
  final int speed;
  final int temporaryHp;
  final String alignment;
  final String background;
  final String castingClass;
  final String characterClass;
  final String characteristics;
  final String characterName;
  final String characterRace;
  final String createdBy;
  final String hitDice;
  final String id;
  final String languages;
  final String skills;

  const Sheet({
    required this.createdAt,
    required this.armorClass,
    required this.attackBonus,
    required this.castingHability,
    required this.characterLevel,
    required this.currentHp,
    required this.iniative,
    required this.magicResistance,
    required this.maxHp,
    required this.speed,
    required this.temporaryHp,
    required this.alignment,
    required this.background,
    required this.castingClass,
    required this.characterClass,
    required this.characteristics,
    required this.characterName,
    required this.characterRace,
    required this.createdBy,
    required this.hitDice,
    required this.id,
    required this.languages,
    required this.skills,
  });

  @override
  List<Object> get props {
    return [
      createdAt,
      armorClass,
      attackBonus,
      castingHability,
      characterLevel,
      currentHp,
      iniative,
      magicResistance,
      maxHp,
      speed,
      temporaryHp,
      alignment,
      background,
      castingClass,
      characterClass,
      characteristics,
      characterName,
      characterRace,
      createdBy,
      hitDice,
      id,
      languages,
      skills,
    ];
  }

  Sheet copyWith({
    DateTime? createdAt,
    int? armorClass,
    int? attackBonus,
    int? castingHability,
    int? characterLevel,
    int? currentHp,
    int? iniative,
    int? magicResistance,
    int? maxHp,
    int? speed,
    int? temporaryHp,
    String? alignment,
    String? background,
    String? castingClass,
    String? characterClass,
    String? characteristics,
    String? characterName,
    String? characterRace,
    String? createdBy,
    String? hitDice,
    String? id,
    String? languages,
    String? skills,
  }) {
    return Sheet(
      createdAt: createdAt ?? this.createdAt,
      armorClass: armorClass ?? this.armorClass,
      attackBonus: attackBonus ?? this.attackBonus,
      castingHability: castingHability ?? this.castingHability,
      characterLevel: characterLevel ?? this.characterLevel,
      currentHp: currentHp ?? this.currentHp,
      iniative: iniative ?? this.iniative,
      magicResistance: magicResistance ?? this.magicResistance,
      maxHp: maxHp ?? this.maxHp,
      speed: speed ?? this.speed,
      temporaryHp: temporaryHp ?? this.temporaryHp,
      alignment: alignment ?? this.alignment,
      background: background ?? this.background,
      castingClass: castingClass ?? this.castingClass,
      characterClass: characterClass ?? this.characterClass,
      characteristics: characteristics ?? this.characteristics,
      characterName: characterName ?? this.characterName,
      characterRace: characterRace ?? this.characterRace,
      createdBy: createdBy ?? this.createdBy,
      hitDice: hitDice ?? this.hitDice,
      id: id ?? this.id,
      languages: languages ?? this.languages,
      skills: skills ?? this.skills,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt.millisecondsSinceEpoch,
      'armorClass': armorClass,
      'attackBonus': attackBonus,
      'castingHability': castingHability,
      'characterLevel': characterLevel,
      'currentHp': currentHp,
      'iniative': iniative,
      'magicResistance': magicResistance,
      'maxHp': maxHp,
      'speed': speed,
      'temporaryHp': temporaryHp,
      'alignment': alignment,
      'background': background,
      'castingClass': castingClass,
      'characterClass': characterClass,
      'characteristics': characteristics,
      'characterName': characterName,
      'characterRace': characterRace,
      'createdBy': createdBy,
      'hitDice': hitDice,
      'id': id,
      'languages': languages,
      'skills': skills,
    };
  }

  factory Sheet.fromMap(Map<String, dynamic> map) {
    return Sheet(
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      armorClass: map['armorClass'] as int,
      attackBonus: map['attackBonus'] as int,
      castingHability: map['castingHability'] as int,
      characterLevel: map['characterLevel'] as int,
      currentHp: map['currentHp'] as int,
      iniative: map['iniative'] as int,
      magicResistance: map['magicResistance'] as int,
      maxHp: map['maxHp'] as int,
      speed: map['speed'] as int,
      temporaryHp: map['temporaryHp'] as int,
      alignment: map['alignment'] as String,
      background: map['background'] as String,
      castingClass: map['castingClass'] as String,
      characterClass: map['characterClass'] as String,
      characteristics: map['characteristics'] as String,
      characterName: map['characterName'] as String,
      characterRace: map['characterRace'] as String,
      createdBy: map['createdBy'] as String,
      hitDice: map['hitDice'] as String,
      id: map['id'] as String,
      languages: map['languages'] as String,
      skills: map['skills'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sheet.fromJson(String source) => Sheet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
