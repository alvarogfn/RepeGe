import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/pages/home_page.dart';
import 'package:repege/pages/login_page.dart';
import 'package:repege/pages/profile/profile_page.dart';
import 'package:repege/pages/register_page.dart';
import 'package:repege/pages/sheets/sheets_page.dart';
import 'package:repege/services/auth_service.dart';

enum RoutesName {
  login(state: AuthState.unauth, name: 'login', path: '/login'),
  register(state: AuthState.unauth, name: 'register', path: '/register'),

  home(state: AuthState.auth, name: 'home', path: '/'),
  profile(state: AuthState.auth, name: 'profile', path: 'profile'),

  sheets(state: AuthState.auth, name: 'sheets', path: '/sheets'),
  tables(state: AuthState.auth, name: 'tables', path: '/tables');

  const RoutesName({
    required this.state,
    required this.name,
    required this.path,
  });

  final AuthState state;
  final String name;
  final String path;
}

class CustomRouter with ChangeNotifier {
  final AuthState authState;
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  late final routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
          path: RoutesName.home.path,
          name: RoutesName.home.name,
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: RoutesName.profile.path,
              name: RoutesName.profile.name,
              builder: (context, state) => const ProfilePage(),
            ),
          ]),
      GoRoute(
        path: RoutesName.login.path,
        name: RoutesName.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutesName.register.path,
        name: RoutesName.register.name,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: RoutesName.sheets.path,
        name: RoutesName.sheets.name,
        builder: (context, state) => SheetsPage(),
      ),
    ],
    redirect: (context, state) {
      final bool toUnauth = RoutesName.values
          .where((element) => element.state == AuthState.unauth)
          .map((e) => e.path)
          .contains(state.subloc);

      if (authState == AuthState.unauth && toUnauth) {
        return null;
      }

      if (authState == AuthState.unauth && !toUnauth) {
        return RoutesName.login.path;
      }

      if (authState == AuthState.auth && toUnauth) {
        return RoutesName.home.path;
      }

      if (authState == AuthState.auth && !toUnauth) {
        return null;
      }

      return RoutesName.home.path;
    },
  );

  CustomRouter({required this.authState});
}
