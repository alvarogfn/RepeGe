import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/sheets/data/models/sheet_model.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_bloc.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_list_bloc.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';
import 'package:repege/src/sheets/domain/entities/sheet.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';

class SheetRepositoryImpl extends SheetRepository {
  final FirebaseFirestore _firestore;

  const SheetRepositoryImpl(this._firestore);

  @override
  Future<SheetListState<SheetModel>?> addSheet({
    required String createdBy,
    int? characterLevel,
    String? alignment,
    String? background,
    String? characterClass,
    String? characteristics,
    String? characterName,
    String? characterRace,
  }) async {
    final sheetDoc = _firestore.collection('sheets').doc();

    final sheet = SheetModel(
      createdAt: DateTime.now(),
      armorClass: 0,
      attackBonus: 0,
      castingHability: 0,
      characterLevel: characterLevel ?? 1,
      currentHp: 0,
      iniative: 0,
      magicResistance: 0,
      maxHp: 0,
      speed: 0,
      temporaryHp: 0,
      alignment: alignment ?? '',
      background: background ?? '',
      castingClass: '',
      characterClass: characterClass ?? '',
      characteristics: characteristics ?? '',
      characterName: characterName ?? '',
      characterRace: characterRace ?? '',
      createdBy: createdBy,
      hitDice: '',
      id: sheetDoc.id,
      languages: '',
      skills: '',
    );

    final sheetMap = sheet.toMap()..update('createdAt', (value) => FieldValue.serverTimestamp());

    await sheetDoc.set(sheetMap);

    return null;
  }

  @override
  Future<SheetListState<Sheet>?> deleteSheet(String sheetId) async {
    try {
      await _sheetsCollection.doc(sheetId).delete();
      return null;
    } catch (e) {
      return SheetListLoadError();
    }
  }

  @override
  Stream<SheetListState<Sheet>> streamAllSheets(String createdBy) {
    return _sheetsCollection.where('createdBy', isEqualTo: createdBy).snapshots().map((snapshot) {
      final items = snapshot.docs.map((snapshot) => snapshot.data()).toList();
      if (items.isEmpty) return const SheetListEmpty();
      return SheetListLoaded(items);
    });
  }

  @override
  Stream<SheetState> streamSheet(String sheetId) {
    return _sheetsCollection.doc(sheetId).snapshots().map((snapshot) => SheetLoaded(snapshot.data()!));
  }

  @override
  Future<SheetUpdateState?> updateSheet({required String sheetId, required DataMap newData}) async {
    try {
      newData
        ..remove('createdAt')
        ..remove('createdBy')
        ..remove('id');

      await _sheetsCollection.doc(sheetId).update(newData);
      return SheetUpdateSucess();
    } catch (e) {
      return const SheetUpdateError();
    }
  }

  CollectionReference<SheetModel> get _sheetsCollection => _firestore.collection('sheets').withConverter(
        fromFirestore: (snapshot, options) => SheetModel.fromFirebase(snapshot),
        toFirestore: (snapshot, options) => snapshot.toMap(),
      );
}
