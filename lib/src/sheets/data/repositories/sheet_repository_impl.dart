import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<SheetListState<SheetModel>?> create(Sheet sheet) async {
    final sheetReference = _collectionReference.doc();

    await sheetReference.set(sheet.copyWith(id: sheetReference.id));

    return null;
  }

  @override
  Future<SheetListLoadError?> delete(String id) async {
    try {
      await _collectionReference.doc(id).delete();
      return null;
    } catch (e) {
      return SheetListLoadError();
    }
  }

  @override
  Stream<SheetListState<SheetModel>> streamAll({required String createdBy}) {
    return _collectionReference.where('createdBy', isEqualTo: createdBy).snapshots().map((snapshot) {
      final items = snapshot.docs.map((snapshot) => snapshot.data() as SheetModel).toList();
      if (items.isEmpty) return const SheetListEmpty();
      return SheetListLoaded(items);
    });
  }

  @override
  Stream<SheetState> stream({required String sheetId}) {
    return _collectionReference.doc(sheetId).snapshots().map((snapshot) => SheetLoaded(snapshot.data()!));
  }

  @override
  Future<SheetUpdateState?> update(Sheet sheet) async {
    try {
      await _collectionReference.doc(sheet.id).update(sheet.toMap());
      return SheetUpdateSucess();
    } catch (e) {
      return const SheetUpdateError();
    }
  }

  CollectionReference<Sheet> get _collectionReference => _firestore.collection('sheets').withConverter(
        fromFirestore: (snapshot, options) => SheetModel.fromMap(snapshot.data()!),
        toFirestore: (snapshot, options) => snapshot.toMap(),
      );
}
