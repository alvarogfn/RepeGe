import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:repege/core/config/environment_variables.dart';
import 'package:repege/core/config/firebase_options.dart';
import 'package:repege/core/routes/routes.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/core/themes/dark_theme.dart';
import 'package:repege/core/themes/light_theme.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (EnvironmentVariables.production == false) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthenticationCubit>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: routes,
        title: 'RepeGe',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        locale: const Locale.fromSubtags(
          languageCode: 'pt',
          countryCode: 'BR',
        ),
      ),
    );
  }
}
