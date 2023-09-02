import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class Equipments {
  late final DocumentReference<Sheet> sheetReference;

  late final CollectionReference<Equipment> collectionReference =
      sheetReference.collection('equipments').withConverter(
            fromFirestore: (snapshot, options) =>
                Equipment.fromMap(snapshot.data()!),
            toFirestore: (equipment, options) => equipment.toMap(),
          );

  Equipments({
    required this.sheetReference,
  });

  Future<Equipment> createEquipment(Map<String, dynamic> data) async {
    final equipmentReference = collectionReference.doc();

    data.putIfAbsent('ref', () => equipmentReference);
    data.putIfAbsent('createdAt', () => FieldValue.serverTimestamp());

    final equipment = Equipment.fromMap(data);

    await equipmentReference.set(equipment);

    return equipment;
  }

  Future<void> deleteEquipment(Equipment equipment) async {
    return equipment.ref.delete();
  }

  Stream<List<Equipment>> stream() {
    return collectionReference.snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }
}
