import 'package:repege/models/dnd/sheets/dnd_utils.dart';

enum DndSpellLevels { l0, l1, l2, l3, l4, l5, l6, l7, l8, l9 }

enum DndSpellTypes { necromancy }

enum DndSpellCatalyts { verbal, somantic, material }

class DnDSpell {
  final DndSpellLevels level;
  final DndSpellTypes type;
  final List<DndSpellCatalyts> catalyts;
  final Duration castingTime;
  final int range;
  final DndDamage damageType;

  DnDSpell({
    required this.level,
    required this.type,
    required this.catalyts,
    required this.castingTime,
    required this.range,
    required this.damageType,
  });
}

class DndSheetSpells {
  final int spellAttackBonus;
  final int spellCastingHability;
  final int spellSaveDc;
  final int spellCastingClass;

  final List<DnDSpell> spells;

  const DndSheetSpells({
    this.spellAttackBonus = 0,
    this.spellCastingHability = 0,
    this.spellSaveDc = 0,
    this.spellCastingClass = 0,
    this.spells = const [],
  });
}
