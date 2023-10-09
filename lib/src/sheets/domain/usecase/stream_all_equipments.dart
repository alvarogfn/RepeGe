import 'package:equatable/equatable.dart';
import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/domain/entities/equipment.dart';
import 'package:repege/src/sheets/domain/repositories/equipment_repository.dart';

class StreamAllEquipments extends UsecaseWithParams<ResultStream<List<Equipment>>, StreamAllEquipmentsParams> {
  const StreamAllEquipments(this._repository);

  final EquipmentRepository _repository;

  @override
  call(params) {
    return _repository.streamAllEquipments(params.createdBy);
  }
}

class StreamAllEquipmentsParams extends Equatable {
  final String createdBy;
  const StreamAllEquipmentsParams({
    required this.createdBy,
  });

  @override
  List<Object> get props => [createdBy];
}
