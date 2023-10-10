// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddSheetParams extends Equatable {
  final String createdBy;
  final int characterLevel;
  final String alignment;
  final String background;
  final String characterClass;
  final String characteristics;
  final String characterName;
  final String characterRace;

  const AddSheetParams({
    required this.createdBy,
    required this.characterLevel,
    required this.alignment,
    required this.background,
    required this.characterClass,
    required this.characteristics,
    required this.characterName,
    required this.characterRace,
  });

  const AddSheetParams.empty({
    required this.createdBy,
    this.characterLevel = 0,
    this.alignment = '',
    this.background = '',
    this.characterClass = '',
    this.characteristics = '',
    this.characterName = '',
    this.characterRace = '',
  });

  AddSheetParams copyWith({
    String? createdBy,
    int? characterLevel,
    String? alignment,
    String? background,
    String? characterClass,
    String? characteristics,
    String? characterName,
    String? characterRace,
  }) {
    return AddSheetParams(
      createdBy: createdBy ?? this.createdBy,
      characterLevel: characterLevel ?? this.characterLevel,
      alignment: alignment ?? this.alignment,
      background: background ?? this.background,
      characterClass: characterClass ?? this.characterClass,
      characteristics: characteristics ?? this.characteristics,
      characterName: characterName ?? this.characterName,
      characterRace: characterRace ?? this.characterRace,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdBy': createdBy,
      'characterLevel': characterLevel,
      'alignment': alignment,
      'background': background,
      'characterClass': characterClass,
      'characteristics': characteristics,
      'characterName': characterName,
      'characterRace': characterRace,
    };
  }

  factory AddSheetParams.fromMap(Map<String, dynamic> map) {
    return AddSheetParams(
      createdBy: map['createdBy'] as String,
      characterLevel: map['characterLevel'] as int,
      alignment: map['alignment'] as String,
      background: map['background'] as String,
      characterClass: map['characterClass'] as String,
      characteristics: map['characteristics'] as String,
      characterName: map['characterName'] as String,
      characterRace: map['characterRace'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddSheetParams.fromJson(String source) => AddSheetParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddSheetParams(createdBy: $createdBy, characterLevel: $characterLevel, alignment: $alignment, background: $background, characterClass: $characterClass, characteristics: $characteristics, characterName: $characterName, characterRace: $characterRace)';
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      createdBy,
      characterLevel,
      alignment,
      background,
      characterClass,
      characteristics,
      characterName,
      characterRace,
    ];
  }
}
