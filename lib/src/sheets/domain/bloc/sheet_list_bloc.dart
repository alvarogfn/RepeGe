import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';

part 'sheet_list_event.dart';
part 'sheet_list_state.dart';

class SheetListBloc extends Bloc<SheetListEvent, SheetListState> {
  final SheetRepository _repository;

  SheetListBloc(this._repository) : super(const SheetListLoading()) {
    on<SheetListInitEvent>((event, emit) async {
      await emit.forEach(_repository.streamAllSheets(event.createdBy), onData: (sheet) {
        return sheet;
      });
    });

    on<SheetListAddEvent>((event, emit) async {
      final result = await _repository.addSheet(
        createdBy: event.createdBy,
        alignment: event.alignment,
        background: event.background,
        characterClass: event.characterClass,
        characterLevel: event.characterLevel,
        characterName: event.characterName,
        characterRace: event.characterRace,
      );

      if (result != null) emit(result);
    });

    on<SheetListRemoveEvent>((event, emit) async {
      final result = await _repository.deleteSheet(event.sheetId);

      if (result != null) emit(result);
    });
  }
}
