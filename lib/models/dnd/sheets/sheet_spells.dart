import 'package:repege/models/dnd/attributes.dart';
import 'package:repege/models/dnd/spell.dart';

class SheetSpells {
  final int spellAttackBonus;
  final int spellCastingHability;
  final int spellSaveDc;
  final Attributes? spellCastingClass;

  final List<Spell> spells;

  const SheetSpells({
    this.spellAttackBonus = 0,
    this.spellCastingHability = 0,
    this.spellSaveDc = 0,
    this.spellCastingClass,
    this.spells = const [],
  });

  factory SheetSpells.fromMap(Map<String, dynamic> sheetDoc) {
    return const SheetSpells();
  }
}
