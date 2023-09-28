import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/modules/character/appearance.dart';
import 'package:repege/modules/equipments/models/bag.dart';
import 'package:repege/modules/casting/models/casting.dart';
import 'package:repege/modules/character/character.dart';
import 'package:repege/modules/status/models/attributes.dart';
import 'package:repege/modules/status/models/status.dart';

class Sheet {
  final String id;
  final String ownerUID;
  final Appearance appearance;
  final Attributes attributes;
  final Bag bag;
  final Casting casting;
  final Character character;
  final Status status;
  final Timestamp? createdAt;

  final DocumentReference ref;

  Sheet({
    required this.id,
    required this.ownerUID,
    required this.appearance,
    required this.attributes,
    required this.bag,
    required this.casting,
    required this.character,
    required this.status,
    required this.createdAt,
    required this.ref,
  });

  factory Sheet.fromMap(Map<String, dynamic> data) {
    return Sheet(
      id: data['id'],
      ownerUID: data['ownerUID'],
      appearance: Appearance.fromMap(data['appearance']),
      bag: Bag.fromMap(data['bag']),
      casting: Casting.fromMap(data['casting']),
      character: Character.fromMap(data['character']),
      status: Status.fromMap(data['status']),
      attributes: Attributes.fromMap(data['attributes']),
      createdAt: data['createdAt'],
      ref: data['ref'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerUID': ownerUID,
      'appearance': appearance.toMap(),
      'attributes': attributes.toMap(),
      'bag': bag.toMap(),
      'casting': casting.toMap(),
      'character': character.toMap(),
      'status': status.toMap(),
    };
  }
}
