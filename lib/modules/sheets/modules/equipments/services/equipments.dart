import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/helpers/parse_string.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment_types.dart';
import 'package:repege/modules/sheets/modules/equipments/models/weapon.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class Equipments {
  late final DocumentReference<Sheet> sheetReference;

  late final CollectionReference<Equipment> collectionReference =
      sheetReference.collection('equipments').withConverter(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          );

  Equipments({
    required this.sheetReference,
  });

  Equipment _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    final type = equipmentTypesFromString(data['type']);
    final name = parseString(data['name']);
    final description = parseString(data['description']);
    final weight = parseString(data['weight']);
    final id = parseString(data['id']);
    final price = parseString(data['price']);
    final ref = data['ref'];
    final createdAt = data['createdAt'];

    if (type == EquipmentTypes.weapon) {
      return Weapon(
        kind: parseString(data['kind']),
        damage: parseString(data['damage']),
        description: description,
        ref: ref,
        id: id,
        createdAt: createdAt,
        name: name,
        price: price,
        weight: weight,
      );
    }

    return Equipment(
      id: id,
      ref: ref,
      name: name,
      description: description,
      createdAt: createdAt,
      price: price,
      weight: weight,
      type: type,
    );
  }

  Map<String, dynamic> _toFirestore(
    Equipment equipment,
    SetOptions? options,
  ) {
    return equipment
        .toMap()
        .putIfAbsent('createdAt', () => FieldValue.serverTimestamp());
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
