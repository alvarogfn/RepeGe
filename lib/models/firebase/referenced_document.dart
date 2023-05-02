import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:repege/models/firebase/document.dart';

class ReferencedDocument<T extends FirestoneDocument<T>> {
  late DocumentReference<T> ref;
  final String id;
  final Timestamp createdAt;

  final T item;

  ReferencedDocument({
    required this.createdAt,
    required this.id,
    required this.item,
    required DocumentReference<T> ref,
  }) {
    this.ref = ref.withConverter(
      fromFirestore: item.fromFirestore,
      toFirestore: item.toFirestore,
    );
  }

  Future<void> delete() async {
    return ref.delete();
  }

  Future<void> updateField({
    required String property,
    required String value,
  }) async {
    await ref.update({property: value});
  }

  Future<void> updateFields(Map<String, Object> data) async {
    await ref.update(data);
  }

}
