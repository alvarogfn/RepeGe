import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:repege/src/authentication/data/models/user_model.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthenticationRepositoryImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  @override
  Future<AuthenticationState> signup({
    required username,
    required password,
    required email,
    createdAt,
    avatarURL,
  }) async {
    final usernameDoc = _firebaseFirestore.collection('usernames').doc(username);
    final usernameRef = await usernameDoc.get();

    if (usernameRef.exists) {
      return const AuthenticationError(message: 'Esse nome de usuário já existe');
    }

    final batch = _firebaseFirestore.batch();

    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user == null) return const Unauthenticated();

    try {
      final userReference = _firebaseFirestore.collection('users').doc(user.uid);

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
      return AuthenticationError(message: e.toString());
    }
  }

  @override
  Future<AuthenticationState> signin({required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        return const Unauthenticated();
      }

      return getUser(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return AuthenticationError(message: e.message ?? '');
    }
  }

  @override
  Stream<AuthenticationState> authStateChanges() {
    return _firebaseAuth.authStateChanges().asyncMap((user) async {
      if (user == null) return const Unauthenticated();
      return getUser(user.uid);
    });
  }

  @override
  Future<AuthenticationState> signout() async {
    await _firebaseAuth.signOut();
    return const Unauthenticated();
  }

  @override
  Future<AuthenticationState?> sendEmailVerification() async {
    try {
      await _firebaseAuth.currentUser!.sendEmailVerification();
      return null;
    } catch (e) {
      return AuthenticationError(message: e.toString());
    }
  }

  CollectionReference<UserModel> get _userCollection => _firebaseFirestore.collection('users').withConverter(
        fromFirestore: (snapshot, options) {
          final user = UserModel.fromFirebase(snapshot);
          return user.copyWith(
            emailVerified: _firebaseAuth.currentUser?.emailVerified,
          );
        },
        toFirestore: (snapshot, options) => snapshot.toMap(),
      );

  Future<AuthenticationState> getUser(String id) async {
    final userModel = await _userCollection.doc(id).get();

    return Authenticated(user: userModel.data()!);
  }
}
