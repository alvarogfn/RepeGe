// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/src/equipments/data/models/equipment_model.dart';
import 'package:repege/src/equipments/domain/bloc/equipment_bloc.dart';

import 'package:repege/src/equipments/domain/entities/equipment.dart';
import 'package:repege/src/equipments/domain/repositories/equipment_repository.dart';

class EquipmentRepositoryImpl extends EquipmentRepository {
  final FirebaseFirestore _firestore;

  EquipmentRepositoryImpl(this._firestore);

  @override
  Future<EquipmentState?> create(Equipment equipment) async {
    final reference = _collectionReference(sheetId: equipment.sheetId).doc();

    await reference.set(equipment.copyWith(id: reference.id));

    return null;
  }

  @override
  Future<EquipmentState?> delete(Equipment equipment) async {
    try {
      await _collectionReference(sheetId: equipment.sheetId).doc(equipment.id).delete();
      return null;
    } catch (e) {
      return EquipmentStateError(e.toString());
    }
  }

  @override
  Stream<EquipmentState> streamAll({required String sheetId}) {
    return _collectionReference(sheetId: sheetId).snapshots().map((snapshot) {
      final items = snapshot.docs.map((snapshot) => snapshot.data() as EquipmentModel).toList();
      if (items.isEmpty) return const EquipmentStateEmpty();
      return EquipmentStateLoaded<EquipmentModel>(items);
    });
  }

  @override
  Future<EquipmentState?> update(Equipment equipment) async {
    try {
      await _collectionReference(sheetId: equipment.sheetId).doc(equipment.id).update(equipment.toMap());
      return null;
    } catch (e) {
      return EquipmentStateError(e.toString());
    }
  }

  CollectionReference<Equipment> _collectionReference({required String sheetId}) =>
      _firestore.collection('sheets').doc(sheetId).collection('equipments').withConverter(
          fromFirestore: (snapshot, _) => EquipmentModel.fromMap(snapshot.data()!),
          toFirestore: (snapshot, _) => snapshot.toMap());
}
