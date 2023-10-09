import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:repege/src/authentication/data/models/user_model.dart';

class AuthenticationRemoteDataSource {
  final _firestore = FirebaseFirestore.instance;
  final _auth = auth.FirebaseAuth.instance;

  late final _userCollection = _firestore.collection('users').withConverter(
        fromFirestore: (snapshot, options) {
          final user = UserModel.fromFirebase(snapshot);
          return user.copyWith(
            emailVerified: _auth.currentUser?.emailVerified,
          );
        },
        toFirestore: (snapshot, options) => snapshot.toMap(),
      );

  Stream<UserModel?> authStateChanges() {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      return getUser(user.uid);
    });
  }

  Future<UserModel> signup({
    required String username,
    required String password,
    required String email,
    DateTime? createdAt,
    String? avatarURL,
  }) async {
    final usernameDoc = _firestore.collection('usernames').doc(username);
    final usernameRef = await usernameDoc.get();

    if (usernameRef.exists) {
      throw Exception(
        'Esse nome de usuário já está cadastrado.',
      );
    }

    final batch = _firestore.batch();

    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) throw Exception();
    try {
      final userReference = _firestore.collection('users').doc(user.uid);

      batch.set(usernameDoc, {
        'createdAt': createdAt != null ? Timestamp.fromDate(createdAt) : FieldValue.serverTimestamp(),
        'createdBy': user.uid,
        'ref': userReference,
      });

      batch.set(userReference, {
        'username': username,
        'uid': user.uid,
        'id': user.uid,
        'email': user.email,
        'emailVerified': user.emailVerified,
        'displayName': user.displayName,
        'phoneNumber': user.phoneNumber,
        'avatarURL': user.photoURL,
        'createdAt': createdAt != null ? Timestamp.fromDate(createdAt) : FieldValue.serverTimestamp(),
      });

      await user.sendEmailVerification();

      await batch.commit();

      return getUser(user.uid);
    } catch (e) {
      await user.delete();
      rethrow;
    }
  }

  Future<UserModel> signin({required email, required password}) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return getUser(credential.user!.uid);
  }

  Future<void> signout() async {
    return _auth.signOut();
  }

  Future<UserModel> getUser(String id) async {
    final userModel = await _userCollection.doc(id).get();

    return userModel.data()!;
  }

  Future<void> editUser(UserModel user) async {
    final credential = _auth.currentUser;

    if (credential == null) throw Exception('Você não está autenticado.');

    await credential.updateEmail(user.email);
    await credential.updatePhotoURL(user.avatarURL);

    await _userCollection.doc(user.id).set(user);
  }

  Future forgotPassword({required String email}) async {
    _auth.sendPasswordResetEmail(email: email);
  }

  Future sendEmailVerification() async {
    if (_auth.currentUser == null) throw Exception('Não autenticado');
    _auth.currentUser!.sendEmailVerification();
  }
}
