import 'package:equatable/equatable.dart';
import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';

class StreamSheet extends UsecaseWithParams<ResultStream<Sheet>, StreamSheetParams> {
  const StreamSheet(this._repository);

  final SheetRepository _repository;

  @override
  call(params) {
    return _repository.streamSheet(params.sheetId);
  }
}

class StreamSheetParams extends Equatable {
  final String sheetId;
  const StreamSheetParams({
    required this.sheetId,
  });

  @override
  List<Object> get props => [sheetId];
}
