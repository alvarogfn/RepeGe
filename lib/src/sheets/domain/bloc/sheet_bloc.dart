import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';

part 'sheet_event.dart';
part 'sheet_state.dart';

class SheetBloc extends Bloc<SheetEvent, SheetState> {
  final SheetRepository _repository;
  SheetBloc(this._repository) : super(const SheetLoading()) {
    on<SheetInitEvent>((event, emit) async {
      await emit.forEach(_repository.streamSheet(event.sheetId), onData: (sheet) {
        return sheet;
      });
    });
  }
}
