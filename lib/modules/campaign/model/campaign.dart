import 'package:cloud_firestore/cloud_firestore.dart';

class Campaign {
  DocumentReference ref;
  String id;
  List<DocumentReference> players;
  DocumentReference ownerRef;
  String ownerUID;
  String name;
  String description;
  Timestamp? createdAt;

  Campaign({
    required this.id,
    required this.ref,
    required this.players,
    required this.ownerRef,
    required this.ownerUID,
    required this.name,
    required this.description,
  });

  factory Campaign.fromMap(Map<String, dynamic> data) {
    return Campaign(
      id: data['id'],
      ref: data['ref'],
      players: data['ref'],
      description: data['description'],
      name: data['name'],
      ownerRef: data['ownerRef'],
      ownerUID: data['ownerUID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ref': ref,
      'players': players,
      'name': name,
      'ownerRef': ownerRef,
      'ownerUID': ownerUID,
      'description': description,
    };
  }
}
