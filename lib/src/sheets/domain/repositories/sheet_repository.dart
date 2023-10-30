import 'package:repege/src/sheets/domain/bloc/sheet_bloc.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_list_bloc.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';

abstract class SheetRepository {
  const SheetRepository();

  Future<SheetListState?> create(Sheet sheet);

  Future<SheetListState?> delete(String id);

  Future<SheetUpdateState?> update(Sheet sheet);

  Stream<SheetState> stream({required String sheetId});

  Stream<SheetListState> streamAll({String? createdBy, List<String>? whereIn});
}
