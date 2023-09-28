import 'package:cloud_firestore/cloud_firestore.dart';

class Campaign {
  DocumentReference ref;
  String id;
  List<DocumentReference> players;
  DocumentReference owner;
  String name;
  String description;
  Timestamp? createdAt;

  Campaign({
    required this.id,
    required this.ref,
    required this.players,
    required this.owner,
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
        owner: data['owner']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ref': ref,
    };
  }
}
