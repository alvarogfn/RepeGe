import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/data/models/bag_model.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';

part 'sheet_update_state.dart';

class SheetUpdateCubit extends Cubit<SheetUpdateState> {
  final SheetRepository _repository;

  SheetUpdateCubit(this._repository) : super(const SheetUpdateInit());

  Future<void> updateSheet({
    required String id,
    required DataMap newData,
  }) async {
    final result = await _repository.updateSheet(sheetId: id, newData: newData);

    if (result != null) emit(result);
  }

  Future<void> updateBag({required Sheet sheet, required DataMap newData}) async {
    final bagModel = sheet.bag.toMap();
    newData.forEach((key, value) => bagModel.update(key, (_) => value));
    _repository.updateSheet(sheetId: sheet.id, newData: sheet.copyWith(bag: BagModel.fromMap(bagModel)).toMap());
  }

  Future<void> updateAttribute({required Sheet sheet, required String name, required int value}) async {
    final newSheet = sheet.copyWith(
      attributes: sheet.attributes.map((attribute) {
        if (attribute.name == name) return attribute.copyWith(value: value);
        return attribute;
      }).toList(),
    );

    return updateSheet(id: sheet.id, newData: newSheet.toMap());
  }

  Future<void> updateSkill({required Sheet sheet, required String name, required bool value}) async {
    final newSheet = sheet.copyWith(
      skills: sheet.skills.map((skill) {
        if (skill.name == name) return skill.copyWith(proficient: value);
        return skill;
      }).toList(),
    );

    return updateSheet(id: sheet.id, newData: newSheet.toMap());
  }
}
