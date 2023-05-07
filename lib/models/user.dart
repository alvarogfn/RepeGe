import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repege/models/dnd/sheets/sheet.dart';
import 'package:repege/models/extensions.dart';
import 'package:repege/services/auth_service.dart';

class User {
  final _firestone = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  late final _ref = _firestone.collection("users").doc(uid).withConverter(
        fromFirestore: fromFirestore,
        toFirestore: toFirestore,
      );

  late final _sheetsRef = _firestone.collection("sheets").withConverter(
        fromFirestore: Sheet.fromFirestore,
        toFirestore: Sheet.toFirestore,
      );

  late final _bucketRef = _storage.ref('users/$uid/');

  final String username;
  final String uid;
  final String email;
  final String? avatarURL;
  final Timestamp createdAt;

  User({
    required this.username,
    required this.uid,
    required this.email,
    required this.createdAt,
    this.avatarURL,
  });

  Future<String> updateAvatar(File newAvatar, [BuildContext? context]) async {
    final ext = newAvatar.path.split(".").last;
    final upload = await _bucketRef.child("avatar.$ext").putFile(
          newAvatar,
          SettableMetadata(contentType: "image/$ext"),
        );

    final url = await upload.ref.getDownloadURL();

    await _ref.update({'avatarURL': url});

    if (context != null && context.mounted) {
      final authService = Provider.of<AuthService>(context, listen: false);
      FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
      await authService.refresh();
    }

    return url;
  }

  Future<List<Sheet>> sheets() async {
    final sheets = await _firestone
        .collection("sheets")
        .orderBy('createdAt')
        .where('ownerUID', isEqualTo: uid)
        .withConverter(
          fromFirestore: (doc, options) => Sheet.fromFirestore(doc, options),
          toFirestore: (sheet, options) => Sheet.toFirestore(sheet, options),
        )
        .get();

    return List<Sheet>.from(
      sheets.docs.map((sheet) => sheet.data()).where((sheet) => sheet != null),
    );
  }

  Stream<List<Sheet>> streamSheets() {
    return _firestone
        .collection("sheets")
        .orderBy('createdAt')
        .where('ownerUID', isEqualTo: uid)
        .withConverter(
          fromFirestore: (doc, options) => Sheet.fromFirestore(doc, options),
          toFirestore: (sheet, options) => Sheet.toFirestore(sheet, options),
        )
        .snapshots()
        .map((query) => query.docs.map((doc) => doc.data()!).toList());
  }

  Future<void> deleteSheet(String id) async {
    return _sheetsRef.doc(id).delete();
  }

  Future<DocumentSnapshot<Sheet?>> createSheet(Sheet sheet) async {
    final batch = _firestone.batch();

    final sheetRef = _sheetsRef.doc();

    final pictureRef = _storage.ref(
      "users/$uid/sheets/${sheetRef.id}/picture",
    );

    sheet.ownerUID = uid;
    try {
      if (sheet.avatarURL.isEmpty) {
        batch.set(sheetRef, sheet);
      } else {
        final File avatarFile = File(sheet.avatarURL);

        await pictureRef.putFile(
          avatarFile,
          SettableMetadata(
            contentType: "image/${avatarFile.ext}",
          ),
        );

        final avatarURL = await pictureRef.getDownloadURL();

        sheet.avatarURL = avatarURL;

        batch.set(sheetRef, sheet);
      }
      await batch.commit();

      return sheetRef.get(const GetOptions(
        serverTimestampBehavior: ServerTimestampBehavior.estimate,
      ));
    } catch (e) {
      await pictureRef.delete().catchError((_) {});
      rethrow;
    }
  }

  Stream<DocumentSnapshot<Sheet?>> sheet(String id) {
    return _sheetsRef.doc(id).snapshots();
  }

  static Future<User?> get(String id) async {
    final userRef = FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore);

    final userDoc = await userRef.get(const GetOptions(
      serverTimestampBehavior: ServerTimestampBehavior.estimate,
    ));

    return userDoc.data();
  }

  static Future<User> create({
    String? avatarURL,
    required String username,
    required String email,
    required String uid,
  }) async {
    final firestone = FirebaseFirestore.instance;

    final userRef = firestone.collection("users").doc(uid).withConverter(
          fromFirestore: fromFirestore,
          toFirestore: toFirestore,
        );

    final usernameRef = firestone.collection("usernames").doc(username);

    final batch = firestone.batch();

    batch.set(usernameRef, {'uid': uid});

    final user = User(
      username: username,
      uid: uid,
      email: email,
      avatarURL: avatarURL,
      createdAt: Timestamp.fromDate(DateTime.now()),
    );

    batch.set<User?>(userRef, user);

    await batch.commit();

    final userDoc = await userRef.get(const GetOptions(
      serverTimestampBehavior: ServerTimestampBehavior.estimate,
    ));

    return userDoc.data()!;
  }

  static Map<String, Object?> toFirestore(User? user, SetOptions? options) {
    if (user == null) return {};

    return {
      'avatarURL': user.avatarURL,
      'email': user.email,
      'uid': user.uid,
      'username': user.username,
      'createdAt': FieldValue.serverTimestamp()
    };
  }

  static User? fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final userDoc = doc.data();

    if (userDoc == null) return null;

    return User(
      avatarURL: userDoc['avatarURL'],
      email: userDoc['email'],
      uid: userDoc['uid'],
      username: userDoc['username'],
      createdAt: userDoc['createdAt'] ?? Timestamp.fromDate(DateTime.now()),
    );
  }
}
