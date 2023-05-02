import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:repege/models/dnd/sheets/sheet_spells.dart';
import 'package:repege/models/utils/field.dart';

class Sheet {
  final _firestone = FirebaseFirestore.instance;

  late final _ref = _firestone.collection("sheets").doc(id).withConverter(
        fromFirestore: fromFirestore,
        toFirestore: toFirestore,
      );

  late final String id;

  final String characterName;
  final String characterClass;
  final String characterRace;
  final String? characterPicture;
  final String background;
  final String aligment;
  final List<String> notes;

  final SheetSpells sheetSpells;

  final Timestamp createdAt;
  final DocumentReference ownerRef;
  final String ownerID;

  Sheet({
    required this.id,
    required this.characterName,
    required this.characterClass,
    required this.characterRace,
    this.characterPicture,
    required this.background,
    required this.aligment,
    required this.createdAt,
    required this.ownerRef,
    required this.ownerID,
    required this.sheetSpells,
    this.notes = const [],
  });

  Future<void> delete() async {
    return _ref.delete();
  }

  Future<void> updateOne({
    required String property,
    required String value,
  }) async {
    await _ref.update({property: value});
  }

  Future<void> updateMany(Map<String, Object> data) async {
    await _ref.update(data);
  }

  List<Field> fields() {
    return [
      Field(label: "Nome", value: characterName, propertyKey: "characterName"),
      Field(
        label: "Classe",
        value: characterClass,
        propertyKey: "characterClass",
      ),
      Field(label: "Alinhamento", value: aligment, propertyKey: "aligment"),
      Field(label: "Background", value: background, propertyKey: "background"),
    ];
  }

  static Future<Sheet> create(Map<String, dynamic> data) async {
    final firestone = FirebaseFirestore.instance;
    final bucket = FirebaseStorage.instance;
    final userID = FirebaseAuth.instance.currentUser!.uid;

    final sheetRef = firestone.collection("sheets").doc().withConverter(
          fromFirestore: fromFirestore,
          toFirestore: toFirestore,
        );

    late String? pictureURL;
    final pictureRef = bucket.ref(
      "users/$userID/sheets/${sheetRef.id}/picture",
    );
    if (data['picture'] != null) {
      final File pictureFile = data['picture'];

      await pictureRef.putFile(
        pictureFile,
        SettableMetadata(
          contentType: "image/${pictureFile.path.split('.').last}",
        ),
      );
      pictureURL = await pictureRef.getDownloadURL();
    }

    pictureURL = null;

    try {
      final sheet = Sheet(
        id: sheetRef.id,
        characterName: data['characterName'],
        characterClass: data['characterClass'],
        characterRace: data['characterRace'],
        characterPicture: pictureURL,
        background: data['background'],
        aligment: data['aligment'],
        sheetSpells: SheetSpells(id: sheetRef.id),
        createdAt: Timestamp(0, 0),
        ownerRef: firestone.collection("users").doc(userID),
        ownerID: userID,
      );

      sheetRef.set(sheet);
    } catch (e) {
      await pictureRef.parent?.delete();
    }

    final sheet = await sheetRef.get(const GetOptions(
      serverTimestampBehavior: ServerTimestampBehavior.estimate,
    ));

    return sheet.data()!;
  }

  static Stream<Sheet?> get(String id) {
    return FirebaseFirestore.instance
        .collection("sheets")
        .doc(id)
        .withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore)
        .snapshots()
        .asyncMap((doc) => doc.data());
  }

  static Map<String, Object?> toFirestore(Sheet? sheet, SetOptions? options) {
    if (sheet == null) return {};
    return {
      'characterName': sheet.characterName,
      'characterClass': sheet.characterClass,
      'characterRace': sheet.characterRace,
      'characterPicture': sheet.characterPicture,
      'background': sheet.background,
      'aligment': sheet.aligment,
      'createdAt': FieldValue.serverTimestamp(),
      'ownerID': sheet.ownerID,
      'ownerRef': sheet.ownerRef,
      'notes': sheet.notes,
      'sheetSpells': {
        'spellAttackBonus': sheet.sheetSpells.spellAttackBonus,
        'spellCastingClass': sheet.sheetSpells.spellCastingClass?.name,
        'spellCastingHability': sheet.sheetSpells.spellCastingHability,
        'spellSaveDc': sheet.sheetSpells.spellSaveDc,
      }
    };
  }

  static Sheet? fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final sheetDoc = doc.data();
    if (sheetDoc == null) return null;

    return Sheet(
      id: doc.id,
      sheetSpells: SheetSpells(id: doc.id),
      characterName: sheetDoc['characterName'],
      characterClass: sheetDoc['characterClass'],
      characterRace: sheetDoc['characterRace'],
      characterPicture: sheetDoc['characterPicture'],
      background: sheetDoc['background'],
      aligment: sheetDoc['aligment'],
      createdAt: sheetDoc['createdAt'] ?? Timestamp.fromDate(DateTime.now()),
      ownerID: sheetDoc['ownerID'],
      ownerRef: sheetDoc['ownerRef'],
      notes: List<String>.from(sheetDoc['notes']),
    );
  }
}
