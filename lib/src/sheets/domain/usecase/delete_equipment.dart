import 'package:equatable/equatable.dart';

import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/domain/repositories/equipment_repository.dart';

class DeleteEquipment extends UsecaseWithParams<ResultVoid, DeleteEquipmentParams> {
  const DeleteEquipment(this._repository);

  final EquipmentRepository _repository;

  @override
  call(params) {
    return _repository.deleteEquipment(params.id);
  }
}

class DeleteEquipmentParams extends Equatable {
  final String id;
  const DeleteEquipmentParams({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
