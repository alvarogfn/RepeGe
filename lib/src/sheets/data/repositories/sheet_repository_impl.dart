import 'package:dartz/dartz.dart';
import 'package:repege/core/errors/failure.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/data/datasources/sheet_remote_data_source.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';

class SheetRepositoryImpl extends SheetRepository {
  final SheetRemoteDataSource remoteDataSource;

  const SheetRepositoryImpl(this.remoteDataSource);

  @override
  ResultFuture<SheetModel> createSheet({
    DateTime? createdAt,
    int? armorClass,
    int? attackBonus,
    int? castingHability,
    int? characterLevel,
    int? currentHp,
    int? iniative,
    int? magicResistance,
    int? maxHp,
    int? speed,
    int? temporaryHp,
    String? alignment,
    String? background,
    String? castingClass,
    String? characterClass,
    String? characteristics,
    String? characterName,
    String? characterRace,
    required String createdBy,
    String? hitDice,
    String? languages,
    String? skills,
  }) async {
    try {
      final sheet = await remoteDataSource.createSheet(
        createdAt: createdAt,
        armorClass: armorClass,
        attackBonus: attackBonus,
        castingHability: castingHability,
        characterLevel: characterLevel,
        currentHp: currentHp,
        iniative: iniative,
        magicResistance: magicResistance,
        maxHp: maxHp,
        speed: speed,
        temporaryHp: temporaryHp,
        alignment: alignment,
        background: background,
        castingClass: castingClass,
        characterClass: characterClass,
        characteristics: characteristics,
        characterName: characterName,
        characterRace: characterRace,
        createdBy: createdBy,
        hitDice: hitDice,
        languages: languages,
        skills: skills,
      );

      return Right(sheet);
    } catch (e) {
      return Left(SheetFailure(message: e.toString()));
    }
  }

  @override
  ResultVoid deleteSheet(String sheetId) async {
    try {
      await remoteDataSource.deleteSheet(sheetId);
      return const Right(null);
    } catch (e) {
      return Left(SheetFailure(message: e.toString()));
    }
  }

  @override
  ResultVoid editSheet({required String sheetId, required DataMap sheetMap}) async {
    try {
      final response = await remoteDataSource.editSheet(sheetId: sheetId, sheetMap: sheetMap);
      return Right(response);
    } catch (e) {
      return Left(SheetFailure(message: e.toString()));
    }
  }

  @override
  ResultStream<List<SheetModel>> streamAllSheets(String createdBy) {
    try {
      final response = remoteDataSource.streamAllSheets(createdBy: createdBy);
      return Right(response);
    } catch (e) {
      return Left(SheetFailure(message: e.toString()));
    }
  }

  @override
  ResultStream<SheetModel> streamSheet(String sheetId) {
    try {
      final response = remoteDataSource.streamSheet(id: sheetId);
      return Right(response);
    } catch (e) {
      return Left(SheetFailure(message: e.toString()));
    }
  }
}
