import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:repege/models/dnd/sheets/sheet_spells.dart';
import 'package:repege/models/utils/field.dart';

class Sheet {
  String? id;
  String characterName;
  String characterClass;
  String characterRace;
  String avatarURL;
  String background;
  String aligment;
  String? ownerUID;
  List<String> notes;

  Timestamp _createdAt = Timestamp.fromDate(DateTime.now());

  SheetSpells sheetSpells;

  Sheet({
    this.id,
    this.characterName = '',
    this.characterClass = '',
    this.characterRace = '',
    this.background = '',
    this.aligment = '',
    this.avatarURL = '',
    this.ownerUID,
    this.sheetSpells = const SheetSpells(),
    this.notes = const [],
  });

  DateTime get createdAt {
    return DateTime.fromMicrosecondsSinceEpoch(
      _createdAt.microsecondsSinceEpoch,
    );
  }

  factory Sheet.fromMap(Map<String, dynamic> sheetDoc, [String? id]) {
    final sheetSpells = SheetSpells.fromMap(sheetDoc['sheetSpells']);

    final sheet = Sheet(
      id: id ?? '',
      sheetSpells: sheetSpells,
      characterName: sheetDoc['characterName'],
      characterClass: sheetDoc['characterClass'],
      characterRace: sheetDoc['characterRace'],
      avatarURL: sheetDoc['avatarURL'],
      background: sheetDoc['background'],
      aligment: sheetDoc['aligment'],
      ownerUID: sheetDoc['ownerUID'],
      notes: List<String>.from(sheetDoc['notes']),
    );

    if (sheetDoc['createdAt'] != null) {
      sheet._createdAt = sheetDoc['createdAt'];
    }

    return sheet;
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

  static Map<String, Object?> toFirestore(Sheet? sheet, SetOptions? options) {
    if (sheet == null) return {};
    return {
      'characterName': sheet.characterName,
      'characterClass': sheet.characterClass,
      'characterRace': sheet.characterRace,
      'avatarURL': sheet.avatarURL,
      'background': sheet.background,
      'aligment': sheet.aligment,
      'createdAt': FieldValue.serverTimestamp(),
      'notes': sheet.notes,
      'sheetSpells': {
        'spellAttackBonus': sheet.sheetSpells.spellAttackBonus,
        'spellCastingClass': sheet.sheetSpells.spellCastingClass?.name,
        'spellCastingHability': sheet.sheetSpells.spellCastingHability,
        'spellSaveDc': sheet.sheetSpells.spellSaveDc,
      },
      'ownerUID': sheet.ownerUID,
    };
  }

  Future<void> updateAvatar() async {
    final bucket = FirebaseStorage.instance;
    final ref = bucket.ref(
      "users/",
    );

    sheetRef.set({avatarURL : ref});
  }

  DocumentReference<dynamic> get sheetRef {
    if (id == null || id?.isEmpty != false) throw Exception();
    print(id);
    return FirebaseFirestore.instance.collection("sheets").doc(id);
  }

  static Sheet? fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final sheetDoc = doc.data();
    if (sheetDoc == null) return null;

    return Sheet.fromMap(sheetDoc, doc.id);
  }

  ImageProvider<Object> get avatar {
    try {
      if (avatarURL.isEmpty) throw Exception();
      final uri = Uri.parse(avatarURL);

      if (uri.host.isEmpty) {
        return FileImage(File(uri.path));
      }
      return NetworkImage(avatarURL);
    } catch (_) {
      return const AssetImage("assets/images/default_avatar.jpg");
    }
  }
}
