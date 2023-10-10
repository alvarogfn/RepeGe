

import 'package:equatable/equatable.dart';

class Attributes extends Equatable {
  final bool atletism;
  final bool sleightOfHand;
  final bool stealth;
  final bool acrobatics;
  final bool arcana;
  final bool history;
  final bool investigation;
  final bool nature;
  final bool religion;
  final bool insight;
  final bool medicine;
  final bool perception;
  final bool survival;
  final bool performance;
  final bool persuasion;
  final bool intimidation;
  final bool deception;
  final int strength;

  final int dextery;
  final int constitution;
  final int intelligence;
  final int wisdom;
  final int charisma;

  final DateTime createdBy;
  final String createdAt;
  final String sheetId;

  const Attributes({
    required this.atletism,
    required this.sleightOfHand,
    required this.stealth,
    required this.acrobatics,
    required this.arcana,
    required this.history,
    required this.investigation,
    required this.nature,
    required this.religion,
    required this.insight,
    required this.medicine,
    required this.perception,
    required this.survival,
    required this.performance,
    required this.persuasion,
    required this.intimidation,
    required this.deception,
    required this.strength,
    required this.dextery,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
    required this.createdBy,
    required this.createdAt,
    required this.sheetId,
  });

  @override
  List<Object> get props {
    return [
      atletism,
      sleightOfHand,
      stealth,
      acrobatics,
      arcana,
      history,
      investigation,
      nature,
      religion,
      insight,
      medicine,
      perception,
      survival,
      performance,
      persuasion,
      intimidation,
      deception,
      strength,
      dextery,
      constitution,
      intelligence,
      wisdom,
      charisma,
      createdBy,
      createdAt,
      sheetId,
    ];
  }
}
