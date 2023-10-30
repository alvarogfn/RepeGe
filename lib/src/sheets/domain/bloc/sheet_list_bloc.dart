import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/authentication/domain/entities/user.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';

part 'sheet_list_event.dart';
part 'sheet_list_state.dart';

class SheetListBloc extends Bloc<SheetListEvent, SheetListState> {
  final SheetRepository _repository;

  SheetListBloc(this._repository) : super(const SheetListLoading()) {
    on<SheetListInitEvent>((event, emit) async {
      await emit.onEach(
        _repository.streamAll(createdBy: event.createdBy, whereIn: event.whereIn),
        onData: (sheet) => emit(sheet),
      );
    });

    on<SheetListAddEvent>((event, emit) async {
      final result = await _repository.create(
        event.sheet.copyWith(
          createdBy: event.user.id,
          createdAt: DateTime.now(),
        ),
      );

      if (result != null) emit(result);
    });

    on<SheetListRemoveEvent>((event, emit) async {
      final result = await _repository.delete(event.sheetId);

      if (result != null) emit(result);
    });
  }
}
