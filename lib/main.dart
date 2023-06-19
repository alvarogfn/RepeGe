import "dart:async";

import "package:flutter/material.dart";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:provider/provider.dart";

import "package:repege/config/route.dart";
import "package:repege/domains/authentication/services/auth_service.dart";
import "package:repege/themes/dark_theme.dart";
import "package:repege/themes/light_theme.dart";

import "config/firebase_options.dart";
 
import "package:repege/config/environment_variables.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (EnvironmentVariables.production == false) {
    FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
    await FirebaseStorage.instance.useStorageEmulator("localhost", 9199);
    await FirebaseAuth.instance.useAuthEmulator("localhost", 9099);
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
      ],
      child: Consumer<AuthService>(builder: (context, value, _) {
        router.routes.refresh();
        return MaterialApp.router(
          routerConfig: router.routes,
          title: "RepeGe",
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          locale: const Locale.fromSubtags(
            languageCode: "pt",
            countryCode: "BR",
          ),
        );
      }),
    );
  }
}
