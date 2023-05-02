import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoneDocument<T extends Object> {
  Map<String, Object?> toFirestore(
    T? doc,
    SetOptions? options,
  );

  T fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  );
}
