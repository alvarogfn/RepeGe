import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repege/models/firebase_model.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class SheetService with ChangeNotifier {
  late DocumentReference<Sheet> _sheetReference;
  late StreamSubscription? _subscription;
  Sheet? _sheet;

  factory SheetService.fromId(String id) {
    return SheetService(_collection.doc(id));
  }

  SheetService(DocumentReference<Sheet> sheet) {
    _sheetReference = sheet;
    _subscription = _stream().listen((sheet) {
      _sheet = sheet;
      notifyListeners();
    });
  }

  Sheet get sheet => _sheet!;

  Future<void> update(FirebaseSheetModel object) {
    return _sheetReference.update({object.propertyKey: object.toMap()});
  }

  Future<void> bulkUpdate(Map<String, dynamic> data) {
    return _sheetReference.update(data);
  }

  Stream<Sheet> _stream() {
    return _sheetReference.snapshots().map((snapshot) => snapshot.data()!);
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
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
