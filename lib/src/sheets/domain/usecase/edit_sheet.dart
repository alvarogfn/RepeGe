// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';

class EditSheet extends UsecaseWithParams<ResultVoid, EditSheetParams> {
  const EditSheet(this._repository);

  final SheetRepository _repository;

  @override
  call(params) {
    return _repository.editSheet(
      sheetId: params.sheetId,
      sheetMap: params.sheetMap,
    );
  }
}

class EditSheetParams {
  final String sheetId;
  final DataMap sheetMap;
  EditSheetParams({
    required this.sheetId,
    required this.sheetMap,
  });
}
