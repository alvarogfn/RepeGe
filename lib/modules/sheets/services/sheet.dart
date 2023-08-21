import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/modules/sheets/models/appearance.dart';
import 'package:repege/modules/sheets/models/attributes.dart';
import 'package:repege/modules/sheets/models/bag.dart';
import 'package:repege/modules/sheets/models/casting.dart';
import 'package:repege/modules/sheets/models/character.dart';
import 'package:repege/modules/sheets/models/status.dart';
import 'package:repege/modules/user/services/user.dart';

class Sheet {
  final DocumentReference<Sheet> ref;
  final String id;
  final String ownerUID;
  final Appearance appearance;
  final Attributes attributes;
  final Bag bag;
  final Casting casting;
  final Character character;
  final Status status;

  Sheet({
    required this.ref,
    required this.id,
    required this.ownerUID,
    required this.appearance,
    required this.attributes,
    required this.bag,
    required this.casting,
    required this.character,
    required this.status,
  });

  static Sheet fromMap(
    Map<String, Object?> data, {
    required String id,
    required DocumentReference<Sheet> ref,
  }) {
    return Sheet(
      ref: ref,
      id: id,
      ownerUID: data['ownerUID'] as String,
      appearance: Appearance.fromMap(
        data['appearance'] as Map<String, Object?>,
      ),
      attributes: Attributes.fromMap(
        data['attributes'] as Map<String, Object?>,
      ),
      bag: Bag.fromMap(
        data['bag'] as Map<String, Object?>,
      ),
      casting: Casting.fromMap(
        data['casting'] as Map<String, Object?>,
      ),
      character: Character.fromMap(
        data['character'] as Map<String, Object?>,
      ),
      status: Status.fromMap(
        data['status'] as Map<String, Object?>,
      ),
    );
  }

  Map<String, Object?> toMap() {
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
    return FirebaseFirestore.instance.collection('sheets').withConverter(
          fromFirestore: (doc, _) => Sheet.fromMap(
            doc.data()!,
            id: doc.id,
            ref: doc.reference as DocumentReference<Sheet>,
          ),
          toFirestore: (sheet, _) => sheet.toMap(),
        );
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
      ref: sheetDoc,
      id: sheetDoc.id,
      ownerUID: user.uid,
      appearance: appearance ?? Appearance(),
      attributes: attributes ?? Attributes(),
      bag: bag ?? Bag(),
      casting: casting ?? Casting(),
      character: character ?? Character(),
      status: status ?? Status(),
    );

    await commit(sheet: sheet);

    return sheet;
  }

  static Future<void> commit({
    required Sheet sheet,
  }) async {
    final batch = FirebaseFirestore.instance.batch();

    batch.set(sheet.ref, sheet);

    await batch.commit();
  }

  static DocumentReference<Sheet> getSheet(String id) {
    return Sheet.collection().doc(id);
  }

  Future<void> delete() {
    return ref.delete();
  }

  static Stream<List<Sheet>> stream() {
    return collection()
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }
}
