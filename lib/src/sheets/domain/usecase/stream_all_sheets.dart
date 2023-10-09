import 'package:equatable/equatable.dart';
import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';

class StreamAllSheets extends UsecaseWithParams<ResultStream<List<Sheet>>, StreamAllSheetsParams> {
  const StreamAllSheets(this._repository);

  final SheetRepository _repository;

  @override
  call(params) {
    return _repository.streamAllSheets(params.createdBy);
  }
}

class StreamAllSheetsParams extends Equatable {
  final String createdBy;
  const StreamAllSheetsParams({
    required this.createdBy,
  });

  @override
  List<Object> get props => [createdBy];
}
