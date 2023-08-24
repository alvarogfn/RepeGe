import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/authentication/screens/signin_screen.dart';
import 'package:repege/modules/authentication/screens/signup_screen.dart';
import 'package:repege/modules/authentication/services/auth_service.dart';
import 'package:repege/modules/authentication/models/auth_state.dart';
import 'package:repege/modules/home/screens/home_page.dart';
import 'package:repege/modules/sheets/screens/sheet_screen.dart';
import 'package:repege/modules/sheets/screens/sheets_create_screen.dart';
import 'package:repege/modules/sheets/screens/sheets_home_screen.dart';
import 'package:repege/modules/user/modules/profile/screens/profile_screen.dart';
import 'package:repege/screens/loading_page.dart';
import 'package:repege/config/environment_variables.dart';

class CustomRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  Listenable? refreshListenable;

  late final routes = GoRouter(
    debugLogDiagnostics: !EnvironmentVariables.production,
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: RoutesName.home.path,
        name: RoutesName.home.name,
        builder: (context, state) => const HomePage(),
        routes: const [],
      ),
      GoRoute(
        path: RoutesName.signin.path,
        name: RoutesName.signin.name,
        builder: (context, state) => const SigninScreen(),
      ),
      GoRoute(
        path: RoutesName.signup.path,
        name: RoutesName.signup.name,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: RoutesName.loading.path,
        name: RoutesName.loading.name,
        builder: (context, state) => const LoadingPage(),
      ),
      GoRoute(
        builder: (context, state) => const ProfileScreen(),
        name: RoutesName.profile.name,
        path: RoutesName.profile.path,
      ),
      GoRoute(
        builder: (context, state) => const SheetsHomeScreen(),
        name: RoutesName.sheets.name,
        path: RoutesName.sheets.path,
        routes: [
          GoRoute(
            builder: (context, state) => const SheetsCreateScreen(),
            path: RoutesName.sheetCreate.path,
            name: RoutesName.sheetCreate.name,
          ),
          GoRoute(
            path: RoutesName.sheet.path,
            name: RoutesName.sheet.name,
            builder: (context, state) => SheetScreen(
              sheetId: state.pathParameters['id'] as String,
            ),
          )
        ],
      ),
    ],
    redirect: (context, state) async {
      final authState = context.read<AuthService>().state;
      final bool toUnauth = RoutesName.values
          .where((element) => element.state == AuthState.unauth)
          .map((e) => e.path)
          .contains(state.matchedLocation);

      if (authState == AuthState.unauth && toUnauth) {
        return null;
      }

      if (authState == AuthState.unauth && !toUnauth) {
        return RoutesName.signin.path;
      }

      if (authState == AuthState.auth && toUnauth) {
        return RoutesName.home.path;
      }

      if (authState == AuthState.auth && !toUnauth) {
        return null;
      }

      return null;
    },
  );
}
