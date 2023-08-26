import 'package:cloud_firestore/cloud_firestore.dart';

class Casts {
  final int level;
  final int maxCasts;
  final int currentCasts;

  Casts({
    required this.level,
    required this.maxCasts,
    required this.currentCasts,
  });

  String get label {
    return 'Slots de nível $level disponíveis';
  }
}

class Casting {
  final int attackBonus;
  final String castingClass;
  final int castingHability;
  final int magicResistance;
  final List<Casts> casts;

  Casting({
    this.attackBonus = 0,
    this.castingClass = '',
    this.castingHability = 0,
    this.magicResistance = 0,
    this.casts = const [],
  });

  static fromMap(Map<String, dynamic> data) {
    return Casting(
      attackBonus: data['attackBonus'] as int,
      castingClass: data['castingClass'] as String,
      castingHability: data['castingHability'] as int,
      magicResistance: data['magicResistance'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attackBonus': attackBonus,
      'castingClass': castingClass,
      'castingHability': castingHability,
      'magicResistance': magicResistance,
    };
  }

  static CollectionReference<Casting> collection() {
    return FirebaseFirestore.instance.collection('bag').withConverter(
          fromFirestore: (snapshot, _) => Casting.fromMap(snapshot.data()!),
          toFirestore: (casting, _) => casting.toMap(),
        );
  }
}
