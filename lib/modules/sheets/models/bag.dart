import 'package:cloud_firestore/cloud_firestore.dart';

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
      copper: data['copper'] as int,
      electrum: data['electrum'] as int,
      gold: data['gold'] as int,
      platinum: data['platinum'] as int,
      silver: data['silver'] as int,
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
