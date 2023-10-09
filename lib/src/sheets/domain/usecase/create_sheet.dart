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
  DateTime? createdAt;
  int? armorClass;
  int? attackBonus;
  int? castingHability;
  int? characterLevel;
  int? currentHp;
  int? iniative;
  int? magicResistance;
  int? maxHp;
  int? speed;
  int? temporaryHp;
  String? alignment;
  String? background;
  String? castingClass;
  String? characterClass;
  String? characteristics;
  String? characterName;
  String? characterRace;
  String createdBy;
  String? hitDice;
  String? id;
  String? languages;
  String? skills;

  CreateSheetParams({
    required this.createdBy,
    this.createdAt,
    this.armorClass,
    this.attackBonus,
    this.castingHability,
    this.characterLevel,
    this.currentHp,
    this.iniative,
    this.magicResistance,
    this.maxHp,
    this.speed,
    this.temporaryHp,
    this.alignment,
    this.background,
    this.castingClass,
    this.characterClass,
    this.characteristics,
    this.characterName,
    this.characterRace,
    this.hitDice,
    this.id,
    this.languages,
    this.skills,
  });
}
