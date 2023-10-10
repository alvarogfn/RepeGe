import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';

part 'sheet_update_state.dart';

class SheetUpdateCubit extends Cubit<SheetUpdateState> {
  final SheetRepository _repository;

  SheetUpdateCubit(this._repository) : super(const SheetUpdateInit());

  Future<void> updateSheet(Sheet sheet) async {
    final result = await _repository.updateSheet(sheet);

    if (result != null) emit(result);
  }
}
