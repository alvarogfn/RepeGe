import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/modules/sheets/models/appearance.dart';
import 'package:repege/modules/sheets/models/attributes.dart';
import 'package:repege/modules/sheets/models/bag.dart';
import 'package:repege/modules/sheets/models/casting.dart';
import 'package:repege/modules/sheets/models/character.dart';
import 'package:repege/modules/sheets/models/spells.dart';
import 'package:repege/modules/sheets/models/status.dart';
import 'package:repege/modules/sheets/modules/equipments/services/equipments.dart';
import 'package:repege/modules/user/services/user.dart';

class Sheet {
  final String id;
  final String ownerUID;
  final Appearance appearance;
  final Attributes attributes;
  final Bag bag;
  final Casting casting;
  final Character character;
  final Status status;
  final Timestamp createdAt;

  late final DocumentReference<Sheet> ref = collection().doc(id);
  late final Spells spells = Spells(sheetID: id, sheetRef: ref);
  late final Equipments equipments = Equipments(sheetReference: ref);

  Sheet({
    required this.id,
    required this.ownerUID,
    required this.appearance,
    required this.attributes,
    required this.bag,
    required this.casting,
    required this.character,
    required this.status,
    required this.createdAt,
  });

  static Sheet fromMap(
    Map<String, dynamic> data, {
    required String id,
  }) {
    return Sheet(
      id: id,
      ownerUID: data['ownerUID'] as String,
      appearance: Appearance.fromMap(data['appearance']),
      bag: Bag.fromMap(data['bag']),
      casting: Casting.fromMap(data['casting']),
      character: Character.fromMap(data['character']),
      status: Status.fromMap(data['status']),
      attributes: Attributes.fromMap(data['attributes']),
      createdAt: (data['createdAt'] as Timestamp?) ??
          Timestamp.fromDate(DateTime.now()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerUID': ownerUID,
      'appearance': appearance.toMap(),
      'attributes': attributes.toMap(),
      'bag': bag.toMap(),
      'casting': casting.toMap(),
      'character': character.toMap(),
      'status': status.toMap(),
    };
  }

  static CollectionReference<Sheet> collection() {
    return FirebaseFirestore.instance.collection('sheets').withConverter<Sheet>(
        fromFirestore: (doc, _) => Sheet.fromMap(
              doc.data()!,
              id: doc.id,
            ),
        toFirestore: (sheet, _) =>
            sheet.toMap()..addAll({'createdAt': FieldValue.serverTimestamp()}));
  }

  static Future<Sheet> createSheet(
    User user, {
    Appearance? appearance,
    Attributes? attributes,
    Bag? bag,
    Casting? casting,
    Character? character,
    Status? status,
  }) async {
    final sheetDoc = Sheet.collection().doc();

    final sheet = Sheet(
      id: sheetDoc.id,
      ownerUID: user.uid,
      appearance: appearance ?? Appearance(),
      attributes: attributes ?? Attributes(),
      bag: bag ?? Bag(),
      casting: casting ?? Casting(),
      character: character ?? Character(),
      status: status ?? Status(),
      createdAt: Timestamp.fromDate(DateTime.now()),
    );

    await sheetDoc.set(sheet);

    return sheet;
  }

  static DocumentReference<Sheet> getSheet(String id) {
    return Sheet.collection().doc(id);
  }

  Future<void> delete() {
    return ref.delete();
  }

  static Stream<List<Sheet>> stream() {
    return collection().snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }
}
