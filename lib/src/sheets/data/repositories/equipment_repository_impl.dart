import 'package:dartz/dartz.dart';
import 'package:repege/core/errors/failure.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/data/datasources/equipment_remote_data_source.dart';
import 'package:repege/src/sheets/data/models/equipment_model.dart';
import 'package:repege/src/sheets/domain/repositories/equipment_repository.dart';

class EquipmentRepositoryImpl extends EquipmentRepository {
  final EquipmentRemoteDataSource remoteDataSource;

  const EquipmentRepositoryImpl(this.remoteDataSource);

  @override
  ResultVoid deleteEquipment(String equipmentId) async {
    try {
      await remoteDataSource.deleteEquipment(equipmentId);
      return const Right(null);
    } catch (e) {
      return Left(SheetFailure(message: e.toString()));
    }
  }

  @override
  ResultVoid editEquipment(String equipmentId, DataMap data) async {
    try {
      final response = await remoteDataSource.editEquipment(equipmentId, data);
      return Right(response);
    } catch (e) {
      return Left(SheetFailure(message: e.toString()));
    }
  }

  @override
  ResultStream<List<EquipmentModel>> streamAllEquipments(String createdBy) {
    try {
      final response = remoteDataSource.streamAllEquipments(createdBy: createdBy);
      return Right(response);
    } catch (e) {
      return Left(SheetFailure(message: e.toString()));
    }
  }

  @override
  ResultStream<EquipmentModel> streamEquipment(String equipmentId) {
    try {
      final response = remoteDataSource.streamEquipment(id: equipmentId);
      return Right(response);
    } catch (e) {
      return Left(SheetFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<EquipmentModel> createEquipment({
    required String sheetId,
    required String createdBy,
    String? description,
    String? name,
    String? price,
    String? weight,
    DateTime? createdAt,
  }) async {
    try {
      final sheet = await remoteDataSource.createEquipment(
        sheetId: sheetId,
        description: description,
        name: name,
        price: price,
        weight: weight,
        createdAt: createdAt,
        createdBy: createdBy,
      );

      return Right(sheet);
    } catch (e) {
      return Left(SheetFailure(message: e.toString()));
    }
  }
}
