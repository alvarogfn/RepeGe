import 'package:cloud_firestore/cloud_firestore.dart';

class ReferencedDocument<T> {
  late DocumentReference<T> ref;
  final String id;
  final Timestamp createdAt;

  final T item;

  ReferencedDocument({
    required this.createdAt,
    required this.id,
    required this.item,
    required this.ref,
  });

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
