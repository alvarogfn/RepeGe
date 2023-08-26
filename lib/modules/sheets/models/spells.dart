import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/spell/models/spell.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Spells {
  final String sheetID;
  late final DocumentReference<Sheet> sheetRef;

  Spells({
    required this.sheetID,
    required this.sheetRef,
  });

  CollectionReference<Spell> collection() {
    return sheetRef.collection('spells').withConverter<Spell>(
          fromFirestore: (doc, _) => Spell.fromMap(
            doc.data()!,
            id: doc.id,
          ),
          toFirestore: (sheet, _) => sheet.toMap()
            ..addAll({'createdAt': FieldValue.serverTimestamp()}),
        );
  }

  Future<Spell> addSpell({
    String name = '',
    String materials = '',
    String description = '',
    String castingTime = '',
    List<String> catalyts = const [],
    String effectType = '',
    int level = 0,
    String type = '',
    String duration = '',
  }) async {
    final spellRef = collection().doc();

    final spell = Spell(
      id: spellRef.id,
      ref: spellRef,
      createdAt: Timestamp.fromDate(DateTime.now()),
      name: name,
      materials: materials,
      description: description,
      castingTime: castingTime,
      catalyts: catalyts,
      effectType: effectType,
      level: level,
      type: type,
      duration: duration,
    );

    await spellRef.set(spell);

    return spell;
  }

  Stream<List<Spell>> stream() {
    return collection().snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  static Future<List<Spell>> fromDnDBook(String value) async {
    final Uri api = Uri.parse(
      'https://dnd-spell.vercel.app/search/spells?s=$value',
    );

    final response = await http.get(api);
    final List<dynamic> json = jsonDecode(response.body);

    return json
        .map((item) => Spell.fromMap(item, id: item['id'].toString()))
        .toList();
  }
}
