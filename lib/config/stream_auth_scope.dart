import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StreamAuthScope extends InheritedNotifier<FirebaseAuthNotifier> {
  /// Creates a [StreamAuthScope] sign in scope.
  StreamAuthScope({
    super.key,
    required super.child,
  }) : super(
          notifier: FirebaseAuthNotifier(),
        );

  /// Gets the [FirebaseAuth].
  static FirebaseAuth of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StreamAuthScope>()!.notifier!.streamAuth;
  }
}

/// A class that converts [FirebaseAuth] into a [ChangeNotifier].
class FirebaseAuthNotifier extends ChangeNotifier {
  /// Creates a [FirebaseAuthNotifier].
  FirebaseAuthNotifier() : streamAuth = FirebaseAuth.instance {
    streamAuth.idTokenChanges().listen((_) {
      notifyListeners();
    });
  }

  /// The stream auth client.
  final FirebaseAuth streamAuth;
}
