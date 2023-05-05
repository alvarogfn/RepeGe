import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Spell? fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final spellDoc = doc.data();
    if (spellDoc == null) return null;

    return Spell.fromMap(spellDoc);
  }

  static Map<String, Object?> toFirestore(
    Spell? spell,
    SetOptions? options,
  ) {
    if (spell == null) return {};

    return {
      'name': spell.name,
      'description': spell.description,
      'castingTime': spell.castingTime,
      'catalyts': spell.catalyts.map((v) => v.name),
      'damageType': spell.damageType?.name,
      'level': spell.level.name,
      'type': spell.type.name,
      'duration': spell.duration,
    };
  }
}
