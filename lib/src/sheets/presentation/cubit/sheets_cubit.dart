import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/domain/usecase/delete_sheet.dart';
import 'package:repege/src/sheets/domain/usecase/stream_all_sheets.dart';
part 'sheets_state.dart';

class SheetsCubit extends Cubit<SheetsState> {
  final StreamAllSheets _streamAllSheets;
  final DeleteSheet _deleteSheet;
  SheetsCubit({
    required StreamAllSheets streamAllSheets,
    required DeleteSheet editSheet,
  })  : _streamAllSheets = streamAllSheets,
        _deleteSheet = editSheet,
        super(const SheetsList([]));

  Future<void> deleteSheet(DeleteSheetParams params) async {
    final result = await _deleteSheet(params);

    result.fold((l) => null, (r) => emit(const SheetsError()));
  }

  StreamSubscription<List<Sheet>>? streamAllSheets(StreamAllSheetsParams params) {
    return _streamAllSheets(params).fold(
      (failure) {
        emit(const SheetsError());
        return;
      },
      (stream) => stream.listen((sheets) => emit(SheetsList(sheets))),
    );
  }
}
