import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';

class CreateSheet extends UsecaseWithParams<ResultFuture<Sheet>, CreateSheetParams> {
  const CreateSheet(this._repository);

  final SheetRepository _repository;

  @override
  call(params) {
    return _repository.createSheet(
      createdAt: params.createdAt,
      armorClass: params.armorClass,
      attackBonus: params.attackBonus,
      castingHability: params.castingHability,
      characterLevel: params.characterLevel,
      currentHp: params.currentHp,
      iniative: params.iniative,
      magicResistance: params.magicResistance,
      maxHp: params.maxHp,
      speed: params.speed,
      temporaryHp: params.temporaryHp,
      alignment: params.alignment,
      background: params.background,
      castingClass: params.castingClass,
      characterClass: params.characterClass,
      characteristics: params.characteristics,
      characterName: params.characterName,
      characterRace: params.characterRace,
      createdBy: params.createdBy,
      hitDice: params.hitDice,
      languages: params.languages,
      skills: params.skills,
    );
  }
}

class CreateSheetParams {
  final DateTime createdAt;
  final int armorClass;
  final int attackBonus;
  final int castingHability;
  final int characterLevel;
  final int currentHp;
  final int iniative;
  final int magicResistance;
  final int maxHp;
  final int speed;
  final int temporaryHp;
  final String alignment;
  final String background;
  final String castingClass;
  final String characterClass;
  final String characteristics;
  final String characterName;
  final String characterRace;
  final String createdBy;
  final String hitDice;
  final String id;
  final String languages;
  final String skills;

  CreateSheetParams({
    required this.createdAt,
    required this.armorClass,
    required this.attackBonus,
    required this.castingHability,
    required this.characterLevel,
    required this.currentHp,
    required this.iniative,
    required this.magicResistance,
    required this.maxHp,
    required this.speed,
    required this.temporaryHp,
    required this.alignment,
    required this.background,
    required this.castingClass,
    required this.characterClass,
    required this.characteristics,
    required this.characterName,
    required this.characterRace,
    required this.createdBy,
    required this.hitDice,
    required this.id,
    required this.languages,
    required this.skills,
  });
}
