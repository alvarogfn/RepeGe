import 'package:equatable/equatable.dart';

abstract class Skills extends Equatable {
  final bool atletism;
  final bool sleightOfHand;
  final bool stealth;
  final bool acrobatics;
  final bool arcana;
  final bool history;
  final bool investigation;
  final bool nature;
  final bool religion;
  final bool insight;
  final bool animalHandling;
  final bool medicine;
  final bool perception;
  final bool survival;
  final bool performance;
  final bool persuasion;
  final bool intimidation;
  final bool deception;

  const Skills({
    required this.atletism,
    required this.sleightOfHand,
    required this.stealth,
    required this.acrobatics,
    required this.arcana,
    required this.history,
    required this.investigation,
    required this.nature,
    required this.religion,
    required this.insight,
    required this.animalHandling,
    required this.medicine,
    required this.perception,
    required this.survival,
    required this.performance,
    required this.persuasion,
    required this.intimidation,
    required this.deception,
  });

  @override
  List<Object> get props {
    return [
      atletism,
      sleightOfHand,
      stealth,
      acrobatics,
      arcana,
      history,
      investigation,
      nature,
      religion,
      insight,
      animalHandling,
      medicine,
      perception,
      survival,
      performance,
      persuasion,
      intimidation,
      deception,
    ];
  }

  Skills copyWithMap(Map<String, dynamic> map);

  Skills copyWith({
    bool? atletism,
    bool? sleightOfHand,
    bool? stealth,
    bool? acrobatics,
    bool? arcana,
    bool? history,
    bool? investigation,
    bool? nature,
    bool? religion,
    bool? insight,
    bool? animalHandling,
    bool? medicine,
    bool? perception,
    bool? survival,
    bool? performance,
    bool? persuasion,
    bool? intimidation,
    bool? deception,
  });

  Map<String, dynamic> toMap();

  String toJson();

  @override
  bool get stringify => true;
}
