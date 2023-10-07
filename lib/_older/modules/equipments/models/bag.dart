import 'package:repege/models/firebase_model.dart';

class Bag extends FirebaseSheetModel {
  late int copper;
  late int electrum;
  late int gold;
  late int platinum;
  late int silver;

  Bag({
    int? copper,
    int? electrum,
    int? gold,
    int? platinum,
    int? silver,
  }) {
    this.copper = copper ?? 0;
    this.electrum = electrum ?? 0;
    this.gold = gold ?? 0;
    this.platinum = platinum ?? 0;
    this.silver = silver ?? 0;
  }

  static Bag fromMap(Map<String, Object?> data) {
    return Bag(
      copper: data['copper'] as int,
      electrum: data['electrum'] as int,
      gold: data['gold'] as int,
      platinum: data['platinum'] as int,
      silver: data['silver'] as int,
    );
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'copper': copper,
      'electrum': electrum,
      'gold': gold,
      'platinum': platinum,
      'silver': silver,
    };
  }

  @override
  String get propertyKey => 'bag';
}
