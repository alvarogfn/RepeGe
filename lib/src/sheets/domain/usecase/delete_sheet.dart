// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';

class DeleteSheet extends UsecaseWithParams<ResultVoid, DeleteSheetParams> {
  const DeleteSheet(this._repository);

  final SheetRepository _repository;

  @override
  call(params) {
    return _repository.deleteSheet(params.id);
  }
}

class DeleteSheetParams extends Equatable {
  final String id;
  const DeleteSheetParams({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
