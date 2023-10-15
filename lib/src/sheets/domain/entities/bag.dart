import 'package:equatable/equatable.dart';
import 'package:repege/core/utils/typedefs.dart';

abstract class Bag extends Equatable {
  final int copper;
  final int electrum;
  final int gold;
  final int platinum;
  final int silver;

  const Bag({
    required this.copper,
    required this.electrum,
    required this.gold,
    required this.platinum,
    required this.silver,
  });

  @override
  List<Object> get props {
    return [
      copper,
      electrum,
      gold,
      platinum,
      silver,
    ];
  }

  Bag copyWithMap(DataMap map);

  Bag copyWith({
    int? copper,
    int? electrum,
    int? gold,
    int? platinum,
    int? silver,
  });

  String toJson();

  @override
  bool get stringify => true;

  DataMap toMap();
}
