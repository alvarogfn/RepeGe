import 'package:repege/models/dnd/sheets/dnd_utils.dart';

class DnDSpell {
  final DnDSpellLevels level;
  final DnDSpellTypes type;
  final List<DnDSpellCatalyts> catalyts;
  final String castingTime;
  final DnDDamage damageType;
  final String name;
  final String description;

  DnDSpell({
    required this.level,
    required this.type,
    required this.catalyts,
    required this.castingTime,
    required this.damageType,
    required this.name,
    required this.description,
  });

  factory DnDSpell.fromMap(Map<String, Object> data) {
    return DnDSpell(
      level: DnDSpellLevels.values.byName(data['level'] as String),
      type: DnDSpellTypes.values.byName(data['type'] as String),
      catalyts: data['catalyts'] as List<DnDSpellCatalyts>,
      castingTime: data['castingTime'] as String,
      damageType: data['damageType'] as DnDDamage,
      name: data['name'] as String,
      description: data['description'] as String,
    );
  }

  Map<String, Object> toMap() {
    return {
      'level': level,
      'type': type,
      'catalyts': catalyts,
      'castingTime': castingTime,
      'damageType': damageType,
      'name': name,
      'description': description,
    };
  }
}

class DnDSheetSpells {
  final int spellAttackBonus;
  final int spellCastingHability;
  final int spellSaveDc;
  final DnDAttributes spellCastingClass;

  final List<DnDSpell> spells;

  const DnDSheetSpells({
    this.spellAttackBonus = 0,
    this.spellCastingHability = 0,
    this.spellSaveDc = 0,
    this.spellCastingClass = DnDAttributes.wisdom,
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
      spellCastingClass: data['spellCastingClass'] as DnDAttributes,
      spells: spells,
    );
  }

  Map<String, Object> toMap() {
    return {
      'spellAttackBonus': spellAttackBonus,
      'spellCastingHability': spellCastingHability,
      'spellSaveDc': spellSaveDc,
      'spellCastingClass': spellCastingClass,
      'spells': spells.map((spell) => spell.toMap()),
    };
  }
}
