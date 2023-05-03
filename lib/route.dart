import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:repege/pages/home_page.dart';
import 'package:repege/pages/login_page.dart';
import 'package:repege/pages/profile/profile_page.dart';
import 'package:repege/pages/register_page.dart';
import 'package:repege/pages/sheet/sub/sheet_spell_create.dart';
import 'package:repege/pages/sheet/sub/sheet_spell_search.dart';
import 'package:repege/pages/sheets/sheet_create_page.dart';
import 'package:repege/pages/sheet/sheet_page.dart';
import 'package:repege/pages/sheets/sheets_page.dart';
import 'package:repege/pages/tables/tables_home_page.dart';
import 'package:repege/services/auth_service.dart';
import 'package:repege/environment_variables.dart';

enum RoutesName {
  login(state: AuthState.unauth, name: 'login', path: '/login'),
  register(state: AuthState.unauth, name: 'register', path: '/register'),

  home(state: AuthState.auth, name: 'home', path: '/'),
  profile(state: AuthState.auth, name: 'profile', path: 'profile'),

  sheets(state: AuthState.auth, name: 'sheets', path: '/sheets'),
  sheet(state: AuthState.auth, name: 'sheet', path: 'sheet/:id'),

  sheetSpellCreate(
    state: AuthState.auth,
    name: 'sheet-spell-create',
    path: 'spell-create',
  ),

  sheetSpellSearch(
    state: AuthState.auth,
    name: 'sheet-spell-search',
    path: 'spell-search',
  ),

  sheetCreate(
    state: AuthState.auth,
    name: 'sheet-create',
    path: 'create',
  ),

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

class CustomRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  Listenable? refreshListenable;

  GoRouter getRouter() {
    return GoRouter(
      debugLogDiagnostics: !EnvironmentVariables.production,
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
          builder: (context, state) => const SheetsPage(),
          routes: [
            GoRoute(
              path: RoutesName.sheetCreate.path,
              name: RoutesName.sheetCreate.name,
              builder: (context, state) => const SheetCreatePage(),
            ),
            GoRoute(
              path: RoutesName.sheet.path,
              name: RoutesName.sheet.name,
              builder: (context, state) => SheetPage(id: state.params['id']!),
              routes: [
                GoRoute(
                  path: RoutesName.sheetSpellCreate.path,
                  name: RoutesName.sheetSpellCreate.name,
                  builder: (context, state) => const SheetSpellCreate(),
                ),
                GoRoute(
                  path: RoutesName.sheetSpellSearch.path,
                  name: RoutesName.sheetSpellSearch.name,
                  builder: (context, state) => const SheetSpellSearch(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: RoutesName.tables.path,
          name: RoutesName.tables.name,
          builder: (context, state) => const TablesHomePage(),
        )
      ],
      refreshListenable: refreshListenable,
      redirect: (context, state) async {
        final authState = context.read<AuthService>().state;
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

        return null;
      },
    );
  }
}
