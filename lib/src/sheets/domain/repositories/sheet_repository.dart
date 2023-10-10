import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_bloc.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_list_bloc.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';

abstract class SheetRepository {
  const SheetRepository();

  Future<SheetListState?> addSheet({
    required String createdBy,
    int? characterLevel,
    String? alignment,
    String? background,
    String? characterClass,
    String? characteristics,
    String? characterName,
    String? characterRace,
  });

  Stream<SheetListState> streamAllSheets(String createdBy);

  Stream<SheetState> streamSheet(String sheetId);

  Future<SheetListState?> deleteSheet(String sheetId);

  Future<SheetUpdateState?> updateSheet({required String sheetId, required DataMap newData});

  // ResultVoid updateAttributes({required String sheetId, required DataMap newData});

  // ResultVoid updateSpells({required String sheetId, required DataMap newData});
  // ResultVoid updateSpell({required String spellId, required DataMap newData});

  // ResultVoid updateBag({required String sheetId, required DataMap newData});
  // ResultVoid updateEquipments({required String sheetId, required DataMap newData});

  // ResultVoid updateEquipment({required String sheetId, required DataMap newData});

  // ResultFuture<Attributes> getAttributes(String sheetId);

  // ResultFuture<Attributes> editAttributes({required String sheetId, required DataMap attributesMap});
}
