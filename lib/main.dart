import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

import 'package:repege/config/route.dart';
import 'package:repege/modules/auth/services/auth_service.dart';
import 'package:repege/themes/dark_theme.dart';
import 'package:repege/themes/light_theme.dart';

import 'config/firebase_options.dart';

import 'package:repege/config/environment_variables.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (EnvironmentVariables.production == false) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final CustomRouter _router = CustomRouter();

  Stream<User?> _getCurrentSignedUser() {
    return FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
          create: (_) => _getCurrentSignedUser(),
          initialData: null,
        ),
        ChangeNotifierProxyProvider<User, AuthService>(
          create: (context) => AuthService(context.read<User>()),
          update: (context, user, authService) {
            if (authService == null) return AuthService(context.read<User>());
            authService.user = user;
            return authService;
          },
        ),
      ],
      builder: (context, child) {
        _router.refreshListenable = context.read<AuthService>();

        return MaterialApp.router(
          routerConfig: _router.routes,
          title: 'RepeGe',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          locale: const Locale.fromSubtags(
            languageCode: 'pt',
            countryCode: 'BR',
          ),
        );
      },
    );
  }
}
