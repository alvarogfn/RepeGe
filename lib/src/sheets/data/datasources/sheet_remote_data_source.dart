import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';

class SheetRemoteDataSource {
  final _firestore = FirebaseFirestore.instance;

  late final _sheetsCollection = _firestore.collection('sheets').withConverter(
        fromFirestore: (snapshot, options) => SheetModel.fromFirebase(snapshot),
        toFirestore: (snapshot, options) => snapshot.toMap(),
      );

  Future<SheetModel> createSheet({
    DateTime? createdAt,
    int? armorClass,
    int? attackBonus,
    int? castingHability,
    int? characterLevel,
    int? currentHp,
    int? iniative,
    int? magicResistance,
    int? maxHp,
    int? speed,
    int? temporaryHp,
    String? alignment,
    String? background,
    String? castingClass,
    String? characterClass,
    String? characteristics,
    String? characterName,
    String? characterRace,
    required String createdBy,
    String? hitDice,
    String? languages,
    String? skills,
  }) async {
    final sheetDoc = _firestore.collection('sheets').doc();

    final sheet = SheetModel(
      createdAt: DateTime.now(),
      armorClass: armorClass ?? 0,
      attackBonus: attackBonus ?? 0,
      castingHability: castingHability ?? 0,
      characterLevel: characterLevel ?? 1,
      currentHp: currentHp ?? 0,
      iniative: iniative ?? 0,
      magicResistance: magicResistance ?? 0,
      maxHp: maxHp ?? 0,
      speed: speed ?? 0,
      temporaryHp: temporaryHp ?? 0,
      alignment: alignment ?? '',
      background: background ?? '',
      castingClass: castingClass ?? '',
      characterClass: characterClass ?? '',
      characteristics: characteristics ?? '',
      characterName: characterName ?? '',
      characterRace: characterRace ?? '',
      createdBy: createdBy,
      hitDice: hitDice ?? '',
      id: sheetDoc.id,
      languages: languages ?? '',
      skills: skills ?? '',
    );

    final sheetMap = sheet.toMap()..update('createdAt', (value) => FieldValue.serverTimestamp());

    await sheetDoc.set(sheetMap);

    return sheet;
  }

  Stream<List<SheetModel>> streamAllSheets({required String createdBy}) {
    return _sheetsCollection
        .where('createdBy', isEqualTo: createdBy)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((snapshot) => snapshot.data()).toList());
  }

  Stream<SheetModel> streamSheet({required String id}) {
    return _sheetsCollection.doc(id).snapshots().map((snapshot) => snapshot.data()!);
  }

  Future<void> editSheet({required String sheetId, required DataMap sheetMap}) async {
    sheetMap
      ..remove('createdAt')
      ..remove('createdBy')
      ..remove('id');

    await _sheetsCollection.doc(sheetId).update(sheetMap);
  }

  Future<void> deleteSheet(String sheetId) async {
    await _sheetsCollection.doc(sheetId).delete();
  }
}
