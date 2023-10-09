import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/usecase/create_sheet.dart';
import 'package:repege/src/sheets/domain/usecase/delete_sheet.dart';
part 'sheets_state.dart';

class SheetsCubit extends Cubit<SheetsState> {
  final DeleteSheet _deleteSheet;
  final CreateSheet _createSheet;

  SheetsCubit({
    required DeleteSheet editSheet,
    required CreateSheet createSheet,
  })  : _deleteSheet = editSheet,
        _createSheet = createSheet,
        super(const SheetsInitialState());

  Future<void> createSheet(CreateSheetParams params) async {
    final result = await _createSheet(params);

    result.fold(
      (failure) => emit(SheetsError(failure.message)),
      (sheet) => emit(SheetsCreated(sheet as SheetModel)),
    );
  }

  Future<void> deleteSheet(DeleteSheetParams params) async {
    final result = await _deleteSheet(params);

    result.fold(
      (failure) => emit(SheetsError(failure.message)),
      (l) => emit(const SheetsDeleted()),
    );
  }
}
