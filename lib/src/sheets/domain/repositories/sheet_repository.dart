import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';

abstract class SheetRepository {
  const SheetRepository();

  ResultFuture<Sheet> createSheet({
    required String createdBy,
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
    String? hitDice,
    String? languages,
    String? skills,
  });

  ResultStream<List<Sheet>> streamAllSheets(String createdBy);

  ResultStream<Sheet> streamSheet(String sheetId);

  ResultVoid deleteSheet(String sheetId);

  ResultVoid editSheet({required String sheetId, required DataMap sheetMap});
}
