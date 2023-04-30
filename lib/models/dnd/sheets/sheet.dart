import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:repege/models/dices/dice_type.dart';

class SheetStatus {
  final DocumentReference<Sheet> ref;

  final int currentHp;
  final int temporaryHp;
  final int iniative;
  final int speed;
  final int armorClass;
  final List<DiceType> hitDice;
  final Map<String, int> deathSaves = {"sucesses": 0, "failures": 0};

  SheetStatus({
    required this.ref,
    this.currentHp = 0,
    this.temporaryHp = 0,
    this.iniative = 0,
    this.speed = 0,
    this.armorClass = 0,
    this.hitDice = const [],
  });

  toMap() {
    return {
      'currentHp': currentHp,
      'temporaryHp': temporaryHp,
      'iniative': iniative,
      'speed': speed,
      'armorClass': armorClass,
      'hitDice': hitDice,
    };
  }
}

class Sheet {
  final firestone = FirebaseFirestore.instance;
  final bucket = FirebaseStorage.instance;

  late final _ref = firestone.collection("sheets").doc(id).withConverter(
        fromFirestore: fromFirestore,
        toFirestore: toFirestore,
      );

  late final String id;

  final String characterName;
  final String characterClass;
  final String characterRace;
  final String characterPicture;
  final String background;
  final String aligment;
  final List<String> notes;

  final Timestamp createdAt;
  final DocumentReference ownerRef;
  final String ownerID;

  Sheet({
    required this.id,
    required this.characterName,
    required this.characterClass,
    required this.characterRace,
    required this.characterPicture,
    required this.background,
    required this.aligment,
    required this.createdAt,
    required this.ownerRef,
    required this.ownerID,
    this.notes = const [],
  });

  Future<void> delete() async {
    return _ref.delete();
  }

  static Future<Sheet> create(Map<String, dynamic> data) async {
    final firestone = FirebaseFirestore.instance;
    final bucket = FirebaseStorage.instance;
    final userID = FirebaseAuth.instance.currentUser!.uid;

    final sheetRef = firestone.collection("sheets").doc().withConverter(
          fromFirestore: fromFirestore,
          toFirestore: toFirestore,
        );

    final File pictureFile = data['picture'];

    final pictureRef = bucket.ref(
      "users/$userID/sheets/${sheetRef.id}/picture",
    );

    await pictureRef.putFile(
      pictureFile,
      SettableMetadata(
        contentType: "image/${pictureFile.path.split('.').last}",
      ),
    );

    final pictureURL = await pictureRef.getDownloadURL();

    try {
      final sheet = Sheet(
        id: sheetRef.id,
        characterName: data['characterName'],
        characterClass: data['characterClass'],
        characterRace: data['characterRace'],
        characterPicture: pictureURL,
        background: data['background'],
        aligment: data['aligment'],
        createdAt: Timestamp(0, 0),
        ownerRef: firestone.collection("users").doc(userID),
        ownerID: userID,
      );

      sheetRef.set(sheet);
    } catch (e) {
      await pictureRef.parent?.delete();
    }

    final sheet = await sheetRef.get(const GetOptions(
      serverTimestampBehavior: ServerTimestampBehavior.estimate,
    ));

    return sheet.data()!;
  }

  static Map<String, Object?> toFirestore(Sheet? sheet, SetOptions? options) {
    if (sheet == null) return {};
    return {
      'characterName': sheet.characterName,
      'characterClass': sheet.characterClass,
      'characterRace': sheet.characterRace,
      'characterPicture': sheet.characterPicture,
      'background': sheet.background,
      'aligment': sheet.aligment,
      'createdAt': FieldValue.serverTimestamp(),
      'ownerID': sheet.ownerID,
      'ownerRef': sheet.ownerRef,
      'notes': sheet.notes,
    };
  }

  static Stream<Sheet?> get(String id) {
    return FirebaseFirestore.instance
        .collection("sheets")
        .doc(id)
        .withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore)
        .snapshots()
        .asyncMap((doc) => doc.data());
  }

  static Sheet? fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final sheetDoc = doc.data();

    if (sheetDoc == null) return null;

    return Sheet(
      id: doc.id,
      characterName: sheetDoc['characterName'],
      characterClass: sheetDoc['characterClass'],
      characterRace: sheetDoc['characterRace'],
      characterPicture: sheetDoc['characterPicture'],
      background: sheetDoc['background'],
      aligment: sheetDoc['aligment'],
      createdAt: sheetDoc['createdAt'],
      ownerID: sheetDoc['ownerID'],
      ownerRef: sheetDoc['ownerRef'],
      notes: List<String>.from(sheetDoc['notes']),
    );
  }
}
