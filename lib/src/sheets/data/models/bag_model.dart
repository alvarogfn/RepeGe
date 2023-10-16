import 'dart:convert';

import 'package:repege/src/sheets/domain/entities/bag.dart';

class BagModel extends Bag {
  const BagModel({
    required super.copper,
    required super.electrum,
    required super.gold,
    required super.platinum,
    required super.silver,
  });

  factory BagModel.empty() {
    return const BagModel(
      copper: 0,
      electrum: 0,
      gold: 0,
      platinum: 0,
      silver: 0,
    );
  }

  @override
  BagModel copyWithMap(map) {
    print({toMap(), map});
    return BagModel.fromMap(toMap()..addAll(map));
  }

  @override
  BagModel copyWith({
    int? copper,
    int? electrum,
    int? gold,
    int? platinum,
    int? silver,
  }) {
    return BagModel(
      copper: copper ?? this.copper,
      electrum: electrum ?? this.electrum,
      gold: gold ?? this.gold,
      platinum: platinum ?? this.platinum,
      silver: silver ?? this.silver,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'copper': copper,
      'electrum': electrum,
      'gold': gold,
      'platinum': platinum,
      'silver': silver,
    };
  }

  @override
  String toJson() => json.encode(toMap());

  factory BagModel.fromJson(String source) => BagModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory BagModel.fromMap(Map<String, dynamic> map) {
    return BagModel(
      copper: map['copper'] as int,
      electrum: map['electrum'] as int,
      gold: map['gold'] as int,
      platinum: map['platinum'] as int,
      silver: map['silver'] as int,
    );
  }
}
