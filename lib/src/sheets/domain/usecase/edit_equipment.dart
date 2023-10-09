import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/domain/repositories/equipment_repository.dart';

class EditEquipment extends UsecaseWithParams<ResultVoid, EditEquipmentParams> {
  const EditEquipment(this._repository);

  final EquipmentRepository _repository;

  @override
  call(params) {
    return _repository.editEquipment(
      params.equipmentId,
      params.equipmentMap,
    );
  }
}

class EditEquipmentParams {
  final String equipmentId;
  final DataMap equipmentMap;

  EditEquipmentParams({
    required this.equipmentId,
    required this.equipmentMap,
  });
}
