import 'dart:convert';

import 'package:repege/src/sheets/domain/entities/skills.dart';

class SkillsModel extends Skills {
  const SkillsModel({
    required super.atletism,
    required super.sleightOfHand,
    required super.stealth,
    required super.acrobatics,
    required super.arcana,
    required super.history,
    required super.investigation,
    required super.nature,
    required super.religion,
    required super.insight,
    required super.animalHandling,
    required super.medicine,
    required super.perception,
    required super.survival,
    required super.performance,
    required super.persuasion,
    required super.intimidation,
    required super.deception,
  });

  factory SkillsModel.empty() {
    return const SkillsModel(
      atletism: false,
      sleightOfHand: false,
      stealth: false,
      acrobatics: false,
      arcana: false,
      history: false,
      investigation: false,
      nature: false,
      religion: false,
      insight: false,
      animalHandling: false,
      medicine: false,
      perception: false,
      survival: false,
      performance: false,
      persuasion: false,
      intimidation: false,
      deception: false,
    );
  }

  @override
  SkillsModel copyWith({
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
  }) {
    return SkillsModel(
      atletism: atletism ?? this.atletism,
      sleightOfHand: sleightOfHand ?? this.sleightOfHand,
      stealth: stealth ?? this.stealth,
      acrobatics: acrobatics ?? this.acrobatics,
      arcana: arcana ?? this.arcana,
      history: history ?? this.history,
      investigation: investigation ?? this.investigation,
      nature: nature ?? this.nature,
      religion: religion ?? this.religion,
      insight: insight ?? this.insight,
      animalHandling: animalHandling ?? this.animalHandling,
      medicine: medicine ?? this.medicine,
      perception: perception ?? this.perception,
      survival: survival ?? this.survival,
      performance: performance ?? this.performance,
      persuasion: persuasion ?? this.persuasion,
      intimidation: intimidation ?? this.intimidation,
      deception: deception ?? this.deception,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'atletism': atletism,
      'sleightOfHand': sleightOfHand,
      'stealth': stealth,
      'acrobatics': acrobatics,
      'arcana': arcana,
      'history': history,
      'investigation': investigation,
      'nature': nature,
      'religion': religion,
      'insight': insight,
      'animalHandling': animalHandling,
      'medicine': medicine,
      'perception': perception,
      'survival': survival,
      'performance': performance,
      'persuasion': persuasion,
      'intimidation': intimidation,
      'deception': deception,
    };
  }

  factory SkillsModel.fromMap(Map<String, dynamic> map) {
    return SkillsModel(
      atletism: map['atletism'] as bool,
      sleightOfHand: map['sleightOfHand'] as bool,
      stealth: map['stealth'] as bool,
      acrobatics: map['acrobatics'] as bool,
      arcana: map['arcana'] as bool,
      history: map['history'] as bool,
      investigation: map['investigation'] as bool,
      nature: map['nature'] as bool,
      religion: map['religion'] as bool,
      insight: map['insight'] as bool,
      animalHandling: map['animalHandling'] as bool,
      medicine: map['medicine'] as bool,
      perception: map['perception'] as bool,
      survival: map['survival'] as bool,
      performance: map['performance'] as bool,
      persuasion: map['persuasion'] as bool,
      intimidation: map['intimidation'] as bool,
      deception: map['deception'] as bool,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory SkillsModel.fromJson(String source) => SkillsModel.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  SkillsModel copyWithMap(Map<String, dynamic> map) {
    return SkillsModel.fromMap(toMap()..addAll(map));
  }
}
