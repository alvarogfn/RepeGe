import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:repege/models/user_model.dart';
import 'package:repege/utils/images.dart';

class UsersDB {
  static final _instance = FirebaseFirestore.instance;
  static final _users = _instance.collection('/users');
  static final _usernames = _instance.collection('/usernames');
  static final _storageInstance = FirebaseStorage.instance;

  static Future<String> get _defaultProfileURL async {
    try {
      return await _storageInstance
          .ref()
          .child('/shared/user.png')
          .getDownloadURL();
    } catch (e) {
      return Images.image1;
    }
  }

  static Future<bool> checkIfUsernameExists(String username) async {
    try {
      final usernameDoc = await _usernames.doc(username).get();
      return usernameDoc.exists;
    } catch (e) {
      return false;
    }
  }

  static Future<void> create({
    String? avatarURL,
    required String username,
    required String email,
    required String uid,
  }) async {
    final batch = _instance.batch();

    final usernameDoc = _usernames.doc(username);

    batch.set(usernameDoc, {'uid': uid});

    final userDoc = _users.doc(uid);

    batch.set(userDoc, {
      'email': email,
      'uid': uid,
      'username': username,
      'avatarURL': avatarURL ?? await _defaultProfileURL,
    });

    return await batch.commit();
  }

  static Future<LoggedUserWithData> findByUID(String uid) async {
    final user = await _users.doc(uid).get();

    if (!user.exists) throw Exception('user not found');

    return LoggedUserWithData.fromMap(user.data()!);
  }
}
