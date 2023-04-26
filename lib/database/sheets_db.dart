import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:repege/models/dnd/sheets/dnd_sheet.dart';

class SheetsDB {
  static final _firestone = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;

  static CollectionReference<Map<String, dynamic>> get _sheetsRef {
    return _firestone.collection("sheets");
  }

  static Future<String> create(String creatorUID, DnDSheet sheet) async {
    final batch = _firestone.batch();

    final sheetRef = _sheetsRef.doc();

    final userRef = _firestone.collection("users").doc(creatorUID);

    batch.set(sheetRef, {
      ...sheet.toJSON(),
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': userRef,
      'creatorUID': creatorUID,
    });

    await batch.commit();

    return sheetRef.id;
  }

  static Future<DnDSheet?> findByID(String id) async {
    final sheetSnapshot = await _sheetsRef.doc(id).get();
    final sheet = sheetSnapshot.data();

    if (sheet == null) return null;

    return DnDSheet.fromJSON(sheet, id: sheetSnapshot.id);
  }

  static Stream<QuerySnapshot<DnDSheet?>> streamOfCreator(String creatorUID) {
    return _sheetsRef
        .withConverter(
          fromFirestore: (snapshot, options) {
            final sheet = snapshot.data();

            if (sheet == null) return null;

            return DnDSheet.fromJSON(sheet, id: snapshot.id);
          },
          toFirestore: (snapshot, options) {
            return snapshot?.toJSON() ?? {};
          },
        )
        .orderBy('createdAt')
        .where('creatorUID', isEqualTo: creatorUID)
        .snapshots();
  }

  static Stream<DocumentSnapshot<DnDSheet?>> streamOfSheet(String id) {
    return _sheetsRef.doc(id)
        .withConverter(
          fromFirestore: (snapshot, options) {
            final sheet = snapshot.data();

            if (sheet == null) return null;

            return DnDSheet.fromJSON(sheet, id: snapshot.id);
          },
          toFirestore: (snapshot, options) {
            return snapshot?.toJSON() ?? {};
          },
        )
        .snapshots();
  }
}
