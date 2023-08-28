import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/helpers/parse_int.dart';
import 'package:repege/helpers/parse_string.dart';

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

  static Casting fromMap(Map<String, dynamic> data) {
    print(data);
    return Casting(
      attackBonus: parseInt(data['attackBonus']),
      castingClass: parseString(data['castingClass']),
      castingHability: parseInt(data['castingHability']),
      magicResistance: parseInt(data['magicResistance']),
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
