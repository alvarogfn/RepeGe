import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/core/config/environment_variables.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/core/services/injection_container.dart';
import 'package:repege/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:repege/src/authentication/presentation/views/forgot_password_screen.dart';
import 'package:repege/src/authentication/presentation/views/signin_screen.dart';
import 'package:repege/src/authentication/presentation/views/signup_screen.dart';
import 'package:repege/src/miscellaneous/presentation/views/home_screen.dart';
import 'package:repege/src/sheets/presentation/cubit/sheets_cubit.dart';
import 'package:repege/src/sheets/presentation/views/sheets_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter routes = GoRouter(
  debugLogDiagnostics: !EnvironmentVariables.production,
  initialLocation: Routes.signin.path,
  refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: Routes.signin.path,
      name: Routes.signin.name,
      builder: (context, state) => const SigninScreen(),
    ),
    GoRoute(
      path: Routes.signup.path,
      name: Routes.signup.name,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: Routes.forgotPassword.path,
      name: Routes.forgotPassword.name,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: Routes.loading.path,
      name: Routes.loading.name,
      builder: (context, state) => const Scaffold(body: Center(child: CircularProgressIndicator())),
    ),
    GoRoute(
      path: Routes.home.path,
      name: Routes.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          create: (context) => sl<SheetsCubit>(),
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: Routes.sheets.path,
          name: Routes.sheets.name,
          builder: (context, state) => const SheetsScreen(),
          routes: [
            // GoRoute(
            //   path: Routes.sheetCreate.path,
            //   name: Routes.sheetCreate.name,
            //   builder: (context, state) => const SheetsCreateScreen(),
            // )
          ],
        ),
        GoRoute(
          path: Routes.sheet.path,
          name: Routes.sheet.name,
          // builder: (context, state) => SheetScreen(''),
        ),
      ],
    ),
  ],
  redirect: (context, state) async {
    // ignore: avoid_print
    print('refreshing');

    final bool toUnauth = Routes.values
        .where((element) => element.state == AuthState.unauth)
        .map((e) => e.path)
        .contains(state.matchedLocation);

    final authState = context.read<AuthenticationCubit>().state;

    final isAuth = authState is Authenticated;

    if (isAuth == false && toUnauth) return null;
    if (isAuth == false && !toUnauth) return Routes.signin.path;
    if (isAuth != false && toUnauth) return Routes.home.path;
    if (isAuth != false && !toUnauth) return null;
    return null;
  },
);

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
