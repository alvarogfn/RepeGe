// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repege/src/sheets/data/models/spell_model.dart';
import 'package:repege/src/spells/domain/bloc/spell_bloc.dart';
import 'package:repege/src/spells/domain/entities/spell.dart';
import 'package:repege/src/spells/domain/repositories/spell_repository.dart';

class SpellRepositoryImpl extends SpellRepository {
  final FirebaseFirestore _firestore;

  SpellRepositoryImpl(this._firestore);

  @override
  Future<SpellState?> create(Spell spell) async {
    final reference = _collectionReference(sheetId: spell.sheetId).doc();

    await reference.set(spell.copyWith(id: reference.id));

    return null;
  }

  @override
  Future<SpellState?> delete(Spell spell) async {
    try {
      await _collectionReference(sheetId: spell.sheetId).doc(spell.id).delete();
      return null;
    } catch (e) {
      return SpellStateError(e.toString());
    }
  }

  @override
  Stream<SpellState> streamAll({required String sheetId}) {
    return _collectionReference(sheetId: sheetId).snapshots().map((snapshot) {
      final items = snapshot.docs.map((snapshot) => snapshot.data() as SpellModel).toList();
      if (items.isEmpty) return const SpellStateEmpty();
      return SpellStateLoaded(items);
    });
  }

  @override
  Future<SpellState?> update(Spell spell) async {
    try {
      await _collectionReference(sheetId: spell.sheetId).doc(spell.id).update(spell.toMap());
      return null;
    } catch (e) {
      return SpellStateError(e.toString());
    }
  }

  CollectionReference<Spell> _collectionReference({required String sheetId}) =>
      _firestore.collection('sheets').doc(sheetId).collection('spells').withConverter(
          fromFirestore: (snapshot, _) => SpellModel.fromMap(snapshot.data()!),
          toFirestore: (snapshot, _) => snapshot.toMap());
}
