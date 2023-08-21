import 'package:cloud_firestore/cloud_firestore.dart';

class Casting {
  final int attackBonus;
  final String castingClass;
  final int castingHability;
  final List<dynamic> spells;

  Casting({
    this.attackBonus = 0,
    this.castingClass = '',
    this.castingHability = 0,
    this.spells = const [],
  });

  static fromMap(Map<String, Object?> data) {
    return Casting(
      attackBonus: int.parse(data['attackBonus'] as String),
      castingClass: data['castingClass'] as String,
      castingHability: int.parse(data['castingHability'] as String),
      spells: data['spells'] as List,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'attackBonus': attackBonus,
      'castingClass': castingClass,
      'castingHability': castingHability,
      'spells': spells,
    };
  }

  static CollectionReference<Casting> collection() {
    return FirebaseFirestore.instance.collection('bag').withConverter(
          fromFirestore: (snapshot, _) => Casting.fromMap(snapshot.data()!),
          toFirestore: (casting, _) => casting.toMap(),
        );
  }
}
