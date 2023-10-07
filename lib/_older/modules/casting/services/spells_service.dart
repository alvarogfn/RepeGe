import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/spell/models/spell.dart';
import 'package:http/http.dart' as http;

class SpellsService with ChangeNotifier {
  Sheet sheet;

  SpellsService(this.sheet);

  Future<void> delete(DocumentReference spell) async {
    return spell.delete();
  }

  Future<void> add(Map<String, dynamic> data) async {
    final doc = collection.doc();
    data.putIfAbsent('id', () => doc.id);
    data.putIfAbsent('ref', () => doc);

    final spell = Spell.fromMap(data);

    return doc.set(spell);
  }

  Stream<List<Spell>> stream() {
    return collection.snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  CollectionReference<Spell> get collection {
    return sheet.ref.collection('spells').withConverter(
          fromFirestore: (snapshot, _) {
            final map = snapshot.data()!;
            return Spell.fromMap(map);
          },
          toFirestore: (spell, _) => spell.toMap(),
        );
  }

  static Future<List<Spell>> fromDnDBook(String value) async {
    final Uri api = Uri.parse(
      'https://dnd-spell.vercel.app/search/spells?s=$value',
    );

    final response = await http.get(api);
    dynamic json = jsonDecode(response.body);
    json = json.map((e) => e.update('id', (value) => value.toString()));

    return json.map((item) => Spell.fromMap(item)).toList();
  }
}
