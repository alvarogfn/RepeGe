// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:repege/_older/modules/equipments/models/bag.dart';
import 'package:repege/src/sheets/domain/entities/attributes.dart';
import 'package:repege/src/sheets/domain/entities/equipment.dart';
import 'package:repege/src/sheets/domain/entities/spell.dart';

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
  final Attributes attributes;
  final List<Spell> spells;
  final List<Equipment> equipments;
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
    required this.characteristics,
    required this.characterName,
    required this.characterRace,
    required this.createdBy,
    required this.hitDice,
    required this.id,
    required this.languages,
    required this.skills,
    required this.attributes,
    required this.spells,
    required this.equipments,
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
      characteristics,
      characterName,
      characterRace,
      createdBy,
      hitDice,
      id,
      languages,
      skills,
      attributes,
      spells,
      equipments,
      bag,
    ];
  }
}
