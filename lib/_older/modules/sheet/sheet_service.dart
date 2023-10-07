import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repege/models/firebase_model.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class SheetService with ChangeNotifier {
  late DocumentReference<Sheet> sheetReference;

  SheetService(String sheetId) {
    sheetReference = _collection.doc(sheetId);
  }


  Future<void> update(FirebaseSheetModel object) {
    return sheetReference.update({object.propertyKey: object.toMap()});
  }

  Future<void> bulkUpdate(Map<String, dynamic> data) {
    return sheetReference.update(data);
  }

  Stream<Sheet> stream() {
    return sheetReference.snapshots().map((snapshot) => snapshot.data()!);
  }

  static CollectionReference<Sheet> get _collection {
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
