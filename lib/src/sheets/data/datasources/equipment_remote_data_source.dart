import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/data/models/equipment_model.dart';

class EquipmentRemoteDataSource {
  final _firestore = FirebaseFirestore.instance;

  late final _equipmentsCollection = _firestore.collection('equipments').withConverter(
        fromFirestore: (snapshot, options) => EquipmentModel.fromFirebase(snapshot),
        toFirestore: (snapshot, options) => snapshot.toMap(),
      );

  Future<EquipmentModel> createEquipment({
    required String sheetId,
    required String createdBy,
    String? name,
    String? description,
    String? price,
    String? weight,
    DateTime? createdAt,
  }) async {
    final equipmentDoc = _firestore.collection('equipments').doc();

    final equipment = EquipmentModel(
      id: equipmentDoc.id,
      name: name ?? '',
      description: description ?? '',
      price: price ?? '',
      weight: weight ?? '',
      createdAt: createdAt ?? DateTime.now(),
      createdBy: createdBy,
      sheetId: sheetId,
    );

    final equipmentMap = equipment.toMap().update('createdAt', (value) => FieldValue.serverTimestamp());

    await equipmentDoc.set(equipmentMap);

    return equipment;
  }

  Stream<List<EquipmentModel>> streamAllEquipments({required String createdBy}) {
    return _equipmentsCollection
        .where('createdBy', isEqualTo: createdBy)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((snapshot) => snapshot.data()).toList());
  }

  Stream<EquipmentModel> streamEquipment({required String id}) {
    return _equipmentsCollection.doc(id).snapshots().map((snapshot) => snapshot.data()!);
  }

  Future<void> editEquipment(String equipmentId, DataMap equipmentMap) async {
    equipmentMap
      ..remove('createdAt')
      ..remove('createdBy')
      ..remove('id');

    await _equipmentsCollection.doc(equipmentId).update(equipmentMap);
  }

  Future<void> deleteEquipment(String equipmentId) async {
    await _equipmentsCollection.doc(equipmentId).delete();
  }
}
