import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

import 'package:repege/route.dart';
import 'package:repege/services/auth_service.dart';
import 'package:repege/themes/dark_theme.dart';
import 'package:repege/themes/light_theme.dart';

import 'firebase_options.dart';

import 'package:repege/environment_variables.dart';

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

  final CustomRouter router = CustomRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
        // ChangeNotifierProxyProvider<AuthService, CustomRouter>(
        //   create: (_) => CustomRouter(authState: AuthState.auth),
        //   update: (_, auth, __) {
        //     return CustomRouter(authState: auth.state);
        //   },
        // )
      ],
      // child: Consumer<AuthService>(
      //   builder: (context, _, child) {
      //     final CustomRouter router = Provider.of(context, listen: false);

      //     return MaterialApp.router(
      //       routerConfig: router.routes,
      //       title: 'RepeGe',
      //       theme: lightTheme,
      //       darkTheme: darkTheme,
      //       themeMode: ThemeMode.system,
      //       debugShowCheckedModeBanner: false,
      //     );
      //   },
      // ),
      child: MaterialApp.router(
        routerConfig: router.routes,
        title: 'RepeGe',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
