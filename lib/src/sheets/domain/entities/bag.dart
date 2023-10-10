// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Bag extends Equatable {
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
}
