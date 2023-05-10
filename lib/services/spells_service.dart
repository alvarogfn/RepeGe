import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:repege/models/dnd/spell.dart';
import 'package:repege/models/extensions.dart';

class SpellService with ChangeNotifier {
  late final _firestoneRef = FirebaseFirestore.instance
      .collection('sheets')
      .doc(sheetID)
      .collection("spells")
      .withConverter(
        fromFirestore: fromFirestore,
        toFirestore: toFirestore,
      );

  final String sheetID;

  SpellService({
    required this.sheetID,
  });

  Stream<List<QueryDocumentSnapshot<Spell>>> streamSpells() {
    return _firestoneRef.snapshots().map((query) {
      final docs = query.docs;
      try {
        final filter = docs
            .map((element) => element as QueryDocumentSnapshot<Spell>)
            .toList();
        print(filter);
      } catch (e) {
        print(e);
      }

      final nonnu = docs.whereType<QueryDocumentSnapshot<Spell>>().toList();
      print(nonnu);
      return nonnu;
    });
  }

  Future<QuerySnapshot<Spell?>> getAllSpells() async {
    return _firestoneRef.get();
  }

  Future<DocumentSnapshot<Spell?>> getSpell(String id) async {
    return _firestoneRef.doc(id).get();
  }

  Future<DocumentSnapshot<Spell?>> addSpell(SpellModel model) async {
    final spellRef = _firestoneRef.doc();

    final spell = Spell(
      id: spellRef.id,
      materials: model.materials,
      catalyts: model.catalyts,
      createdAt: Timestamp.now(),
      description: model.description,
      duration: model.duration,
      effectType: model.effectType,
      level: model.level,
      name: model.name,
      type: model.type,
      castingTime: model.castingTime,
      range: model.range,
    );

    await spellRef.set(spell);

    return spellRef.get(const GetOptions(
      serverTimestampBehavior: ServerTimestampBehavior.estimate,
    ));
  }

  removeSpell(String id) {
    return _firestoneRef.doc(id).delete();
  }

  static Future<List<SpellModel>> getBookSpells(String value) async {
    final Uri api = Uri.parse(
      "https://dnd-spell.vercel.app/search/spells?s=$value",
    );

    final response = await http.get(api);
    final List<dynamic> json = jsonDecode(response.body);

    return json.map((item) => SpellModel.fromMap(item)).toList();
  }

  Spell? fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final spellDoc = doc.data();
    if (spellDoc == null) return null;

    return Spell(
      id: doc.id,
      createdAt: spellDoc['createdAt'],
      level: spellDoc['level'],
      range: spellDoc['range'],
      type: spellDoc['type'],
      materials: spellDoc['materials'],
      catalyts: List<String>.from(spellDoc['catalyts']).toList(),
      castingTime: spellDoc['castingTime'],
      effectType: spellDoc['effectType'],
      duration: spellDoc['duration'],
      name: spellDoc['name'],
      description: spellDoc['description'],
    );
  }

  Map<String, Object?> toFirestore(
    Spell? spell,
    SetOptions? options,
  ) {
    if (spell == null) return {};

    return {
      'createdAt': FieldValue.serverTimestamp(),
      'name': spell.name,
      'description': spell.description,
      'castingTime': spell.castingTime,
      'materials': spell.materials,
      'catalyts': spell.catalyts,
      'effectType': spell.effectType,
      'level': spell.level,
      'type': spell.type,
      'duration': spell.duration,
      'range': spell.range,
    };
  }
}
