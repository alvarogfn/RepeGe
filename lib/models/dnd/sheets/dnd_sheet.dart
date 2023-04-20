import 'dart:math';

import 'package:repege/models/dnd/sheets/dnd_attributes.dart';
import 'package:repege/models/dnd/sheets/dnd_bag.dart';
import 'package:repege/models/dnd/sheets/dnd_spells.dart';
import 'package:repege/models/dnd/sheets/dnd_status.dart';

class DnDSheet {
  final String id = Random().nextInt(20000).toString();
  final String characterName;
  final String characterClass;
  final String characterRace;
  final int level;
  final String background;
  final String aligment;
  final double experiencePoints;
  final List<String> languages;
  final bool inspiration;

  final DnDSheetAttributes attributes;
  final DnDSheetWeapons weapons;
  final DnDSheetStatus status;
  final DndSheetSpells spells;
  final DndSheetBag bag;

  DnDSheet({
    required this.characterName,
    required this.characterClass,
    required this.characterRace,
    this.level = 1,
    required this.background,
    required this.aligment,
    this.experiencePoints = 0,
    required this.attributes,
    required this.weapons,
    required this.status,
    required this.spells,
    required this.bag,
    required this.languages,
    required this.inspiration,
  });
}

class DnDSheetWeapons {}
