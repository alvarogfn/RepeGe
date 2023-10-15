import 'package:equatable/equatable.dart';

abstract class Attributes extends Equatable {
  final int strength;
  final int dextery;
  final int constitution;
  final int intelligence;
  final int wisdom;
  final int charisma;

  const Attributes({
    required this.strength,
    required this.dextery,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      strength,
      dextery,
      constitution,
      intelligence,
      wisdom,
      charisma,
    ];
  }

  Attributes copyWithMap(Map<String, dynamic> map);

  Attributes copyWith({
    int? strength,
    int? dextery,
    int? constitution,
    int? intelligence,
    int? wisdom,
    int? charisma,
  });

  Map<String, dynamic> toMap();

  String toJson();
}
