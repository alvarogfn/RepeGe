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

  factory DnDSpell.fromMap(Map<String, Object> data) {
    return DnDSpell(
      level: data['level'] as DndSpellLevels,
      type: data['type'] as DndSpellTypes,
      catalyts: data['catalyts'] as List<DndSpellCatalyts>,
      castingTime: data['castingTime'] as Duration,
      range: data['range'] as int,
      damageType: data['damageType'] as DndDamage,
    );
  }
}

class DnDSheetSpells {
  final int spellAttackBonus;
  final int spellCastingHability;
  final int spellSaveDc;
  final int spellCastingClass;

  final List<DnDSpell> spells;

  const DnDSheetSpells({
    this.spellAttackBonus = 0,
    this.spellCastingHability = 0,
    this.spellSaveDc = 0,
    this.spellCastingClass = 0,
    this.spells = const [],
  });

  factory DnDSheetSpells.fromMap(Map<String, Object> data) {
    final List<DnDSpell> spells = (data['spells'] as List<Map<String, Object>>)
        .map((e) => DnDSpell.fromMap(data['spells'] as Map<String, Object>))
        .toList();

    return DnDSheetSpells(
      spellAttackBonus: data['spellAttackBonus'] as int,
      spellCastingHability: data['spellCastingHability'] as int,
      spellSaveDc: data['spellSaveDc'] as int,
      spellCastingClass: data['spellCastingClass'] as int,
      spells: spells,
    );
  }
}
