import 'dart:convert';

import 'package:repege/src/sheets/domain/entities/attributes.dart';

class AttributesModel extends Attributes {
  const AttributesModel({
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
    required super.medicine,
    required super.perception,
    required super.survival,
    required super.performance,
    required super.persuasion,
    required super.intimidation,
    required super.deception,
    required super.strength,
    required super.dextery,
    required super.constitution,
    required super.intelligence,
    required super.wisdom,
    required super.charisma,
    required super.createdBy,
    required super.createdAt,
    required super.sheetId,
  });

  Attributes copyWith({
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
    bool? medicine,
    bool? perception,
    bool? survival,
    bool? performance,
    bool? persuasion,
    bool? intimidation,
    bool? deception,
    int? strength,
    int? dextery,
    int? constitution,
    int? intelligence,
    int? wisdom,
    int? charisma,
    DateTime? createdBy,
    String? createdAt,
    String? sheetId,
  }) {
    return Attributes(
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
      medicine: medicine ?? this.medicine,
      perception: perception ?? this.perception,
      survival: survival ?? this.survival,
      performance: performance ?? this.performance,
      persuasion: persuasion ?? this.persuasion,
      intimidation: intimidation ?? this.intimidation,
      deception: deception ?? this.deception,
      strength: strength ?? this.strength,
      dextery: dextery ?? this.dextery,
      constitution: constitution ?? this.constitution,
      intelligence: intelligence ?? this.intelligence,
      wisdom: wisdom ?? this.wisdom,
      charisma: charisma ?? this.charisma,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      sheetId: sheetId ?? this.sheetId,
    );
  }

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
      'medicine': medicine,
      'perception': perception,
      'survival': survival,
      'performance': performance,
      'persuasion': persuasion,
      'intimidation': intimidation,
      'deception': deception,
      'strength': strength,
      'dextery': dextery,
      'constitution': constitution,
      'intelligence': intelligence,
      'wisdom': wisdom,
      'charisma': charisma,
      'createdBy': createdBy.millisecondsSinceEpoch,
      'createdAt': createdAt,
      'sheetId': sheetId,
    };
  }

  factory AttributesModel.fromMap(Map<String, dynamic> map) {
    return AttributesModel(
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
      medicine: map['medicine'] as bool,
      perception: map['perception'] as bool,
      survival: map['survival'] as bool,
      performance: map['performance'] as bool,
      persuasion: map['persuasion'] as bool,
      intimidation: map['intimidation'] as bool,
      deception: map['deception'] as bool,
      strength: map['strength'] as int,
      dextery: map['dextery'] as int,
      constitution: map['constitution'] as int,
      intelligence: map['intelligence'] as int,
      wisdom: map['wisdom'] as int,
      charisma: map['charisma'] as int,
      createdBy: DateTime.fromMillisecondsSinceEpoch(map['createdBy'] as int),
      createdAt: map['createdAt'] as String,
      sheetId: map['sheetId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributesModel.fromJson(String source) =>
      AttributesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
