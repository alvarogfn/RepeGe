import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/domain/entities/equipment.dart';

abstract class EquipmentRepository {
  const EquipmentRepository();

  ResultFuture<Equipment> createEquipment({
    String? name,
    String? description,
    String? price,
    String? weight,
    DateTime? createdAt,
    required String createdBy,
    required String sheetId,
  });

  ResultVoid editEquipment(String equipmentId, DataMap data);
  ResultStream<List<Equipment>> streamAllEquipments(String createdBy);
  ResultStream<Equipment> streamEquipment(String equipmentId);
  ResultVoid deleteEquipment(String equipmentId);
}
