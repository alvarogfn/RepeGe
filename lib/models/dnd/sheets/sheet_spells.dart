import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:repege/models/dnd/attributes.dart';
import 'package:repege/models/dnd/spell.dart';

class SheetSpells {
  final _firestone = FirebaseFirestore.instance;
  // final _bucket = FirebaseStorage.instance;

  late final _ref = _firestone.collection("sheets").doc(id);

  late final _spellsRef = _ref.collection("spells").withConverter(
        fromFirestore: fromFirestore,
        toFirestore: toFirestore,
      );

  final String id;
  final int spellAttackBonus;
  final int spellCastingHability;
  final int spellSaveDc;
  final Attributes? spellCastingClass;

  final List<Spell> spells;

  SheetSpells({
    required this.id,
    this.spellAttackBonus = 0,
    this.spellCastingHability = 0,
    this.spellSaveDc = 0,
    this.spellCastingClass,
    this.spells = const [],
  });

  Future<DocumentReference<Spell?>> add(Spell spell) async {
    return await _spellsRef.add(spell);
  }

  Future<List<Spell>> fetch() async {
    final spells = await FirebaseFirestore.instance
        .collection("sheets")
        .doc(id)
        .collection("spells")
        .withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore)
        .get();

    return List.from(
      spells.docs.map((doc) => doc.data()).where((doc) => doc != null),
    );
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
