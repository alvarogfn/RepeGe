import 'package:repege/core/usecases/usecase.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/domain/entities/equipment.dart';
import 'package:repege/src/sheets/domain/repositories/equipment_repository.dart';

class CreateEquipment extends UsecaseWithParams<ResultFuture<Equipment>, CreateEquipmentParams> {
  const CreateEquipment(this._repository);

  final EquipmentRepository _repository;

  @override
  call(params) {
    return _repository.createEquipment(
      name: params.name,
      description: params.description,
      price: params.price,
      weight: params.weight,
      createdAt: params.createdAt,
      createdBy: params.createdBy,
      sheetId: params.sheetId,
    );
  }
}

class CreateEquipmentParams {
  final String? name;
  final String? description;
  final String? price;
  final String? weight;
  final DateTime? createdAt;
  final String createdBy;
  final String sheetId;

  const CreateEquipmentParams({
    this.name,
    this.description,
    this.price,
    this.weight,
    this.createdAt,
    required this.createdBy,
    required this.sheetId,
  });
}
