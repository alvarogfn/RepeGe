import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/usecase/stream_all_sheets.dart';

part 'sheet_list_state.dart';

class SheetListCubit extends Cubit<SheetListState> {
  final StreamAllSheets _streamAllSheets;

  SheetListCubit({
    required StreamAllSheets streamAllSheets,
  })  : _streamAllSheets = streamAllSheets,
        super(const SheetListEmpty());

  StreamSubscription? streamAllSheets(StreamAllSheetsParams params) {
    return _streamAllSheets(params).fold(
      (failure) => null,
      (stream) => stream.listen((sheets) {
        if (sheets.isEmpty) return emit(const SheetListEmpty());
        return emit(SheetListLoaded(sheets as List<SheetModel>));
      }),
    );
  }
}
