import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/helpers/parse_string.dart';

class Equipment {
  late final DocumentReference<Equipment> ref;
  late final String id;
  late final String title;
  late final String description;
  late final String valuation;
  late final String attributes;
  late final Timestamp createdAt;

  Equipment({
    required this.id,
    required this.ref,
    required this.title,
    required this.description,
    required this.valuation,
    required this.attributes,
    required this.createdAt,
  });

  Equipment.fromMap(Map<String, dynamic> data) {
    id = parseString(data['id']);
    ref = data[''];
    title = parseString(data['title']);
    description = parseString(data['description']);
    valuation = parseString(data['valuation']);
    attributes = parseString(data['attributes']);
    createdAt = data['createdAt'] ?? Timestamp.fromDate(DateTime.now());
  }

  Map<String, dynamic> toMap() {
    return {
      'ref': ref,
      'title': title,
      'description': description,
      'valuation': valuation,
      'attributes': attributes,
      'createdAt': createdAt,
    };
  }
}
