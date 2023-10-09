import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/src/sheets/data/models/equipment_model.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';

class EquipmentRemoteDataSource {
  final _firestore = FirebaseFirestore.instance;

  late final _sheetsCollection = _firestore.collection('equipments').withConverter(
        fromFirestore: (snapshot, options) => SheetModel.fromFirebase(snapshot),
        toFirestore: (snapshot, options) => snapshot.toMap(),
      );

  Future<EquipmentModel> createEquipment({
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

    final sheet = EquipmentModel(
      createdAt: DateTime.now(),
      armorClass: 0,
      attackBonus: 0,
      castingHability: 0,
      characterLevel: 1,
      currentHp: 0,
      iniative: 0,
      magicResistance: 0,
      maxHp: 0,
      speed: 0,
      temporaryHp: 0,
      alignment: '',
      background: '',
      castingClass: '',
      characterClass: '',
      characteristics: '',
      characterName: '',
      characterRace: '',
      createdBy: createdBy,
      hitDice: '',
      id: sheetDoc.id,
      languages: '',
      skills: '',
    );

    final sheetMap = sheet.toMap().update('createdAt', (value) => FieldValue.serverTimestamp());

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

  Future<SheetModel> editSheet(SheetModel sheet) async {
    await _sheetsCollection.doc(sheet.id).set(sheet);
    return sheet;
  }

  Future<void> deleteSheet(SheetModel sheet) async {
    await _sheetsCollection.doc(sheet.id).delete();
  }
}
