import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/helpers/parse_int.dart';
import 'package:repege/helpers/parse_string.dart';
import 'package:repege/models/firebase_model.dart';

class Casting implements FirebaseSheetModel {
  int attackBonus;
  String castingClass;
  int castingHability;
  int magicResistance;

  Casting({
    this.attackBonus = 0,
    this.castingClass = '',
    this.castingHability = 0,
    this.magicResistance = 0,
  });

  static Casting fromMap(Map<String, dynamic> data) {
    return Casting(
      attackBonus: parseInt(data['attackBonus']),
      castingClass: parseString(data['castingClass']),
      castingHability: parseInt(data['castingHability']),
      magicResistance: parseInt(data['magicResistance']),
    );
  }

  @override
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

  @override
  String get propertyKey => 'casting';
}
