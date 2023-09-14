import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/helpers/parse_bool.dart';
import 'package:repege/helpers/parse_int.dart';
import 'package:repege/helpers/parse_string.dart';
import 'package:repege/modules/equipments/models/armor.dart';
import 'package:repege/modules/equipments/models/equipment.dart';
import 'package:repege/modules/equipments/models/equipment_types.dart';
import 'package:repege/modules/equipments/models/weapon.dart';

class Equipments {
  late final DocumentReference sheetReference;

  late final CollectionReference<Equipment> ref = sheetReference.collection('equipments').withConverter(
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
    final name = parseString(data['name']);
    final description = parseString(data['description']);
    final weight = parseString(data['weight']);
    final id = snapshot.id;
    final price = parseString(data['price']);

    final equipmentRef = ref.doc(snapshot.id);

    final createdAt = data['createdAt'] ?? Timestamp.fromDate(DateTime.now());

    final type = equipmentTypesFromString(data['type']);

    if (type == EquipmentTypes.weapon) {
      return Weapon(
        kind: parseString(data['kind']),
        damage: parseString(data['damage']),
        description: description,
        ref: equipmentRef,
        id: id,
        createdAt: createdAt,
        name: name,
        price: price,
        weight: weight,
      );
    }

    if (type == EquipmentTypes.armor) {
      return Armor(
        kind: parseString(data['kind']),
        armorClass: parseString(data['armorClass']),
        isStealth: parseBool(data['isStealth']),
        minStrength: parseInt(data['minStrength']),
        description: description,
        ref: equipmentRef,
        id: id,
        createdAt: createdAt,
        name: name,
        price: price,
        weight: weight,
      );
    }

    return Equipment(
      id: id,
      ref: equipmentRef,
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
    return equipment.toMap()..putIfAbsent('createdAt', () => FieldValue.serverTimestamp());
  }

  Future<void> deleteEquipment(Equipment equipment) async {
    return equipment.ref.delete();
  }

  Future<void> addEquipmentFromMap(Map<String, dynamic> data) {
    final equipmentRef = ref.doc();

    EquipmentTypes type = data['type'];

    data.putIfAbsent('ref', () => equipmentRef);
    switch (type) {
      case EquipmentTypes.armor:
        return equipmentRef.set(Armor.fromMap(data));
      case EquipmentTypes.weapon:
        return equipmentRef.set(Weapon.fromMap(data));
      default:
        return equipmentRef.set(Equipment.fromMap(data));
    }
  }

  Stream<List<Equipment>> stream() {
    return ref.snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }
}
