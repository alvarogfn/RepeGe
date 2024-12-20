import 'package:equatable/equatable.dart';

import 'package:repege/src/sheets/domain/entities/attributes.dart';
import 'package:repege/src/sheets/domain/entities/bag.dart';
import 'package:repege/src/sheets/domain/entities/skills.dart';

abstract class Sheet extends Equatable {
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
  final String characterName;
  final String characterRace;
  final String createdBy;
  final String hitDice;
  final String id;
  final String languages;
  final Attributes attributes;
  final Skills skills;
  final Bag bag;

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
    required this.characterName,
    required this.characterRace,
    required this.createdBy,
    required this.hitDice,
    required this.id,
    required this.languages,
    required this.attributes,
    required this.skills,
    required this.bag,
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
      characterName,
      characterRace,
      createdBy,
      hitDice,
      id,
      languages,
      attributes,
      skills,
      bag,
    ];
  }

  Map<String, dynamic> toMap();

  String toJson();

  Sheet copyWithMap(Map<String, dynamic> map);

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
    String? characterName,
    String? characterRace,
    String? createdBy,
    String? hitDice,
    String? id,
    String? languages,
    Attributes? attributes,
    Skills? skills,
    Bag? bag,
  });

  @override
  bool get stringify => true;
}
