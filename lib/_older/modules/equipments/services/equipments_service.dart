import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repege/helpers/parse_bool.dart';
import 'package:repege/helpers/parse_int.dart';
import 'package:repege/helpers/parse_string.dart';
import 'package:repege/modules/equipments/models/armor.dart';
import 'package:repege/modules/equipments/models/equipment.dart';
import 'package:repege/modules/equipments/models/equipment_types.dart';
import 'package:repege/modules/equipments/models/weapon.dart';
import 'package:repege/modules/sheets/services/sheet.dart';

class EquipmentsService with ChangeNotifier {
  Sheet sheet;

  EquipmentsService(this.sheet);

  Future<void> delete(Equipment equipment) async {
    return equipment.ref.delete();
  }

  Future<void> add(Map<String, dynamic> data) {
    final equipmentRef = collection.doc();

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
    return collection.snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  CollectionReference<Equipment> get collection {
    return sheet.ref.collection('equipments').withConverter<Equipment>(
      fromFirestore: (snapshot, options) {
        final data = snapshot.data()!;
        final name = parseString(data['name']);
        final description = parseString(data['description']);
        final weight = parseString(data['weight']);
        final id = snapshot.id;
        final price = parseString(data['price']);

        final equipmentRef = snapshot.reference;

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
      },
      toFirestore: (equipment, _) {
        return equipment.toMap()..putIfAbsent('createdAt', () => FieldValue.serverTimestamp());
      },
    );
  }
}
