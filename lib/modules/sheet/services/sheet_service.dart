import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/models/dnd/sheets/sheet_spells.dart';
import 'package:repege/models/extensions.dart';
import 'package:repege/modules/user/services/user.dart';

class SheetService with ChangeNotifier {
  late final _firestoneRef = FirebaseFirestore.instance
      .collection('sheets')
      .withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore);

  late final _storageRef = FirebaseStorage.instance.ref(
    'users/${user.uid}/sheets',
  );

  final User user;

  SheetService({required this.user});

  DocumentReference<Sheet?> getSheetRef(String sheetID) {
    return _firestoneRef.doc(sheetID);
  }

  Future<void> deleteSheet(String id) async {
    await _firestoneRef.doc(id).delete();
    notifyListeners();
  }

  Stream<List<Sheet>> streamAllSheets() {
    return _firestoneRef
        .orderBy('createdAt')
        .where('ownerUID', isEqualTo: user.uid)
        .withConverter(
          fromFirestore: (doc, options) => fromFirestore(doc, options),
          toFirestore: (sheet, options) => toFirestore(sheet, options),
        )
        .snapshots()
        .map((query) => query.docs.map((doc) => doc.data()!).toList());
  }

  Future<DocumentSnapshot<Sheet?>> createSheet(SheetModel data) async {
    final batch = FirebaseFirestore.instance.batch();

    final sheetRef = _firestoneRef.doc();

    String? avatarURL;

    if (data.avatarFile != null) {
      avatarURL = await updateSheetAvatar(
        sheetRef.id,
        data.avatarFile!,
        shouldUpdateDocument: false,
      );
    }

    try {
      final sheet = Sheet.fromModel(
        data,
        id: sheetRef.id,
        ownerUID: user.uid,
        avatarURL: avatarURL,
        createdAt: Timestamp.fromDate(DateTime.now()),
      );

      batch.set(sheetRef, sheet);

      await batch.commit();

      return sheetRef.get(const GetOptions(
        serverTimestampBehavior: ServerTimestampBehavior.estimate,
      ));
    } catch (e) {
      await _storageRef
          .child('${sheetRef.id}/picture')
          .delete()
          .catchError((_) {});

      rethrow;
    }
  }

  Future<List<Sheet>> getAllSheets() async {
    final sheets = await _firestoneRef
        .orderBy('createdAt')
        .where('ownerUID', isEqualTo: user.uid)
        .get();

    return List<Sheet>.from(
      sheets.docs.map((sheet) => sheet.data()).where((sheet) => sheet != null),
    );
  }

  Future<void> updateSheet(String id, Map<String, dynamic> data) async {
    if (data['avatarURL']) {
      throw Exception('Cannot update avatarURL, use updateAvatar.');
    }
    return _firestoneRef.doc(id).update(data);
  }

  Future<String> updateSheetAvatar(
    String sheetID,
    File newAvatar, {
    bool shouldUpdateDocument = true,
  }) async {
    final sheetRef = _firestoneRef.doc(sheetID);
    final pictureRef = _storageRef.child('${sheetRef.id}/picture');

    await pictureRef.putFile(
      newAvatar,
      SettableMetadata(contentType: 'image/${newAvatar.ext}'),
    );

    final avatarURL = await pictureRef.getDownloadURL();

    if (shouldUpdateDocument) {
      await sheetRef.update({'avatarURL': avatarURL});
    }

    return avatarURL;
  }

  Map<String, Object?> toFirestore(Sheet? sheet, SetOptions? options) {
    if (sheet == null) return {};
    return {
      'characterName': sheet.characterName,
      'characterClass': sheet.characterClass,
      'characterRace': sheet.characterRace,
      'avatarURL': sheet.avatarURL,
      'background': sheet.background,
      'alignment': sheet.alignment,
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

  Sheet? fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final sheetDoc = doc.data();
    if (sheetDoc == null) return null;
    return Sheet(
      id: doc.id,
      ownerUID: sheetDoc['ownerUID'],
      createdAt: sheetDoc['createdAt'],
      avatarURL: sheetDoc['avatarURL'],
      characterName: sheetDoc['characterName'],
      characterClass: sheetDoc['characterClass'],
      characterRace: sheetDoc['characterRace'],
      background: sheetDoc['background'],
      alignment: sheetDoc['alignment'],
      notes: List<String>.from(sheetDoc['notes']),
      sheetSpells: const SheetSpells(),
    );
  }
}
