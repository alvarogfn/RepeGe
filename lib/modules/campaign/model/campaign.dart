import 'package:cloud_firestore/cloud_firestore.dart';

class Campaign {
  DocumentReference ref;
  String id;
  List<String> sheets;
  List<String> participants;
  DocumentReference ownerRef;
  String ownerUID;
  String name;
  String description;
  Timestamp? createdAt;

  Campaign({
    required this.id,
    required this.ref,
    required this.sheets,
    required this.participants,
    required this.ownerRef,
    required this.ownerUID,
    required this.name,
    required this.description,
    this.createdAt,
  });

  factory Campaign.fromMap(Map<String, dynamic> data) {
    return Campaign(
      id: data['id'],
      ref: data['ref'],
      sheets: List.from(data['sheets']).map((e) => e.toString()).toList(),
      participants: List.from(data['participants']).map((e) => e.toString()).toList(),
      description: data['description'],
      name: data['name'],
      ownerRef: data['ownerRef'],
      ownerUID: data['ownerUID'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ref': ref,
      'sheets': sheets,
      'participants': participants,
      'name': name,
      'ownerRef': ownerRef,
      'ownerUID': ownerUID,
      'description': description,
    };
  }
}
