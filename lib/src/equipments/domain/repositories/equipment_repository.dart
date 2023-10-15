import 'package:repege/src/equipments/domain/bloc/equipment_bloc.dart';
import 'package:repege/src/equipments/domain/entities/equipment.dart';

abstract class EquipmentRepository {
  const EquipmentRepository();

  Future<EquipmentState?> create(Equipment equipment);

  Future<EquipmentState?> delete(String id);

  Future<EquipmentState?> update(Equipment equipment);

  Stream<EquipmentState> streamAll({required String createdBy});
}
