import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/domain/usecase/delete_sheet.dart';
import 'package:repege/src/sheets/domain/usecase/edit_sheet.dart';
import 'package:repege/src/sheets/domain/usecase/stream_sheet.dart';

part 'sheet_state.dart';

class SheetCubit extends Cubit<SheetState> {
  final DeleteSheet _deleteSheet;
  final EditSheet _editSheet;
  final StreamSheet _streamSheet;

  SheetCubit({
    required DeleteSheet deleteSheet,
    required EditSheet editSheet,
    required StreamSheet streamSheet,
  })  : _deleteSheet = deleteSheet,
        _editSheet = editSheet,
        _streamSheet = streamSheet,
        super(const SheetLoading());

  StreamSubscription<Sheet>? streamSheet(StreamSheetParams params) {
    return _streamSheet(params).fold(
      (failure) {
        emit(SheetError(failure.message));
        return;
      },
      (sheet) {
        return sheet.listen((event) {
          emit(SheetLoaded(event as SheetModel));
        });
      },
    );
  }

  Future<void> deleteSheet(DeleteSheetParams params) async {
    final result = await _deleteSheet(params);

    return result.fold(
      (failure) => emit(SheetError(failure.message)),
      (sheet) => emit(SheetDeleted(params.id)),
    );
  }

  Future<void> editSheet(SheetModel sheet) async {
    final result = await _editSheet(
      EditSheetParams(sheetId: sheet.id, sheetMap: sheet.toMap()),
    );

    return result.fold(
      (failure) => emit(SheetError(failure.message)),
      (_) => emit(const SheetUpdated()),
    );
  }
}
