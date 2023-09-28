import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:repege/modules/character/appearance.dart';
import 'package:repege/modules/equipments/models/bag.dart';
import 'package:repege/modules/casting/models/casting.dart';
import 'package:repege/modules/character/character.dart';
import 'package:repege/modules/sheets/services/sheet.dart';
import 'package:repege/modules/status/models/attributes.dart';
import 'package:repege/modules/status/models/status.dart';

class SheetsService extends ChangeNotifier {
  User user;

  SheetsService(this.user);

  Stream<Sheet> streamOf(String sheetId) {
    return collection.doc(sheetId).snapshots().map((event) => event.data()!);
  }

  Stream<List<Sheet>> streamAll() {
    final snapshots = collection.where('ownerUID', isEqualTo: user.uid).snapshots();

    return snapshots.map((snapshots) {
      return snapshots.docs.map((doc) {
        final sheet = doc.data();
        return sheet;
      }).toList();
    });
  }

  Future<Sheet> post({
    Appearance? appearance,
    Attributes? attributes,
    Bag? bag,
    Casting? casting,
    Character? character,
    Status? status,
  }) async {
    final ref = collection.doc();

    final sheet = Sheet(
      id: ref.id,
      ownerUID: user.uid,
      appearance: appearance ?? Appearance(),
      attributes: attributes ?? Attributes(),
      bag: bag ?? Bag(),
      casting: casting ?? Casting(),
      character: character ?? Character(),
      status: status ?? Status(),
      createdAt: null,
      ref: ref,
    );

    await ref.set(sheet);

    return sheet;
  }

  Future<DocumentSnapshot<Sheet>> get(String id) async {
    return collection.doc(id).get();
  }

  CollectionReference<Sheet> get collection {
    return FirebaseFirestore.instance.collection('sheets').withConverter<Sheet>(
          fromFirestore: (snapshot, _) {
            final sheetMap = snapshot.data()!;
            sheetMap.putIfAbsent('id', () => snapshot.id);
            sheetMap.putIfAbsent('ref', () => snapshot.reference);

            return Sheet.fromMap(sheetMap);
          },
          toFirestore: (sheet, _) => sheet.toMap()..putIfAbsent('createdAt', () => FieldValue.serverTimestamp()),
        );
  }
}
