import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/helpers/parse_int.dart';

class Bag {
  final int copper;
  final int electrum;
  final int gold;
  final int platinum;
  final int silver;

  Bag({
    this.copper = 0,
    this.electrum = 0,
    this.gold = 0,
    this.platinum = 0,
    this.silver = 0,
  });

  static Bag fromMap(Map<String, Object?> data) {
    return Bag(
      copper: parseInt(data['copper']),
      electrum: parseInt(data['electrum']),
      gold: parseInt(data['gold']),
      platinum: parseInt(data['platinum']),
      silver: parseInt(data['silver']),
    );
  }

  Map<String, Object?> toMap() {
    return {
      'copper': copper,
      'electrum': electrum,
      'gold': gold,
      'platinum': platinum,
      'silver': silver,
    };
  }

  static CollectionReference<Bag> collection() {
    return FirebaseFirestore.instance.collection('bag').withConverter<Bag>(
          fromFirestore: (snapshot, _) => Bag.fromMap(snapshot.data()!),
          toFirestore: (bag, _) => bag.toMap(),
        );
  }
}
