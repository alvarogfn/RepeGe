import 'dart:convert';
import 'package:repege/src/sheets/data/models/attributes_model.dart';
import 'package:repege/src/sheets/data/models/bag_model.dart';
import 'package:repege/src/sheets/data/models/skills_model.dart';
import 'package:repege/src/sheets/domain/entities/attributes.dart';
import 'package:repege/src/sheets/domain/entities/bag.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/domain/entities/skills.dart';

class SheetModel extends Sheet {
  const SheetModel({
    required super.createdAt,
    required super.armorClass,
    required super.attackBonus,
    required super.castingHability,
    required super.characterLevel,
    required super.currentHp,
    required super.iniative,
    required super.magicResistance,
    required super.maxHp,
    required super.speed,
    required super.temporaryHp,
    required super.alignment,
    required super.background,
    required super.castingClass,
    required super.characterClass,
    required super.characterName,
    required super.characterRace,
    required super.createdBy,
    required super.hitDice,
    required super.id,
    required super.languages,
    required super.attributes,
    required super.skills,
    required super.bag,
  });

  factory SheetModel.empty() {
    return SheetModel(
      createdAt: DateTime.now(),
      armorClass: 0,
      attackBonus: 0,
      castingHability: 0,
      characterLevel: 1,
      currentHp: 0,
      iniative: 0,
      magicResistance: 0,
      maxHp: 0,
      speed: 0,
      temporaryHp: 0,
      alignment: '',
      background: '',
      castingClass: '',
      characterClass: '',
      characterName: '',
      characterRace: '',
      createdBy: '',
      hitDice: '',
      id: '',
      languages: '',
      attributes: AttributesModel.empty(),
      skills: SkillsModel.empty(),
      bag: BagModel.empty(),
    );
  }

  @override
  SheetModel copyWith({
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
    String? characterName,
    String? characterRace,
    String? createdBy,
    String? hitDice,
    String? id,
    String? languages,
    Attributes? attributes,
    Skills? skills,
    Bag? bag,
  }) {
    return SheetModel(
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
      characterName: characterName ?? this.characterName,
      characterRace: characterRace ?? this.characterRace,
      createdBy: createdBy ?? this.createdBy,
      hitDice: hitDice ?? this.hitDice,
      id: id ?? this.id,
      languages: languages ?? this.languages,
      attributes: attributes ?? this.attributes,
      skills: skills ?? this.skills,
      bag: bag ?? this.bag,
    );
  }

  @override
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
      'characterName': characterName,
      'characterRace': characterRace,
      'createdBy': createdBy,
      'hitDice': hitDice,
      'id': id,
      'languages': languages,
      'attributes': attributes.toMap(),
      'skills': skills.toMap(),
      'bag': bag.toMap(),
    };
  }

  @override
  SheetModel copyWithMap(Map<String, dynamic> map) {
    return SheetModel.fromMap(toMap()..addAll(map));
  }

  factory SheetModel.fromMap(Map<String, dynamic> map) {
    return SheetModel(
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
      characterName: map['characterName'] as String,
      characterRace: map['characterRace'] as String,
      createdBy: map['createdBy'] as String,
      hitDice: map['hitDice'] as String,
      id: map['id'] as String,
      languages: map['languages'] as String,
      attributes: AttributesModel.fromMap(map['attributes'] as Map<String, dynamic>),
      skills: SkillsModel.fromMap(map['skills'] as Map<String, dynamic>),
      bag: BagModel.fromMap(map['bag'] as Map<String, dynamic>),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory SheetModel.fromJson(String source) => SheetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
