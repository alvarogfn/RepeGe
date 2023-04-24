import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:repege/models/user_model.dart';

class UsersDB {
  final _instance = FirebaseFirestore.instance;
  final _storageInstance = FirebaseStorage.instance;
  late final _users = _instance.collection('/users');
  late final _usernames = _instance.collection('/usernames');

  Future<bool> checkIfUsernameExists(String username) async {
    try {
      final usernameDoc = await _usernames.doc(username).get();
      return usernameDoc.exists;
    } catch (e) {
      return false;
    }
  }

  Future<void> create({
    required String avatarURL,
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
      'avatarURL': avatarURL != ''
          ? avatarURL
          : await _storageInstance
              .ref()
              .child('/shared/user.png')
              .getDownloadURL(),
    });

    return await batch.commit();
  }

  Future<LoggedUserWithData> findByUID(String uid) async {
    final user = await _users.doc(uid).get();

    if (!user.exists) throw Exception('user not found');

    return LoggedUserWithData.fromMap(user.data()!);
  }
}
