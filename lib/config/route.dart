import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/config/routes_name.dart';
import 'package:repege/modules/authentication/screens/signin_screen.dart';
import 'package:repege/modules/authentication/screens/signup_screen.dart';
import 'package:repege/modules/authentication/models/auth_state.dart';
import 'package:repege/modules/home/screens/home_page.dart';
import 'package:repege/modules/sheets/modules/equipments/models/equipment.dart';
import 'package:repege/modules/sheets/modules/equipments/screens/equipment_screen.dart';
import 'package:repege/modules/sheets/modules/equipments/screens/equipment_form_screen.dart';
import 'package:repege/modules/sheets/modules/equipments/screens/equipment_search_screen.dart';
import 'package:repege/modules/sheets/screens/sheet_screen.dart';
import 'package:repege/modules/sheets/screens/sheets_create_screen.dart';
import 'package:repege/modules/sheets/screens/sheets_home_screen.dart';
import 'package:repege/modules/spell/models/spell.dart';
import 'package:repege/modules/spell/screens/spell_details_screen.dart';
import 'package:repege/modules/spell/screens/spell_search_screen.dart';
import 'package:repege/modules/tables/screens/table_create_screen.dart';
import 'package:repege/modules/tables/screens/table_home_screen.dart';
import 'package:repege/modules/user/modules/profile/screens/profile_screen.dart';
import 'package:repege/screens/loading_page.dart';
import 'package:repege/config/environment_variables.dart';

class CustomRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  late final routes = GoRouter(
    debugLogDiagnostics: !EnvironmentVariables.production,
    initialLocation: '/',
    refreshListenable: GoRouterRefreshListenable(
      FirebaseAuth.instance.authStateChanges(),
    ),
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
      GoRoute(
        builder: (context, state) => const SpellSearchScreen(),
        name: RoutesName.spells.name,
        path: RoutesName.spells.path,
        routes: [
          GoRoute(
            builder: (context, state) => const SpellSearchScreen(),
            path: RoutesName.spellsSearch.path,
            name: RoutesName.spellsSearch.name,
          ),
          GoRoute(
            builder: (context, state) => SpellDetailsScreen(
              spell: state.extra as Spell,
            ),
            path: RoutesName.spellDetails.path,
            name: RoutesName.spellDetails.name,
          ),
        ],
      ),
      GoRoute(
        builder: (context, state) => EquipmentScreen(state.extra as Equipment),
        name: RoutesName.equipments.name,
        path: RoutesName.equipments.path,
        routes: [
          GoRoute(
            builder: (context, state) => const EquipmentSearchScreen(),
            path: RoutesName.equipmentsSearch.path,
            name: RoutesName.equipmentsSearch.name,
          ),
          GoRoute(
            builder: (context, state) => EquipmentFormScreen(
              state.extra as Equipment?,
            ),
            path: RoutesName.equipmentsForm.path,
            name: RoutesName.equipmentsForm.name,
          ),
        ],
      ),
      GoRoute(
        path: RoutesName.tables.path,
        name: RoutesName.tables.name,
        builder: (context, state) => const TableHomeScreen(),
        routes: [
          GoRoute(
            path: RoutesName.tablesCreate.path,
            name: RoutesName.tablesCreate.name,
            builder: (context, state) => const TableCreateScreen(),
          ),
        ],
      )
    ],
    redirect: (context, state) async {
      final bool toUnauth = RoutesName.values
          .where((element) => element.state == AuthState.unauth)
          .map((e) => e.path)
          .contains(state.matchedLocation);

      final user = FirebaseAuth.instance.currentUser;

      if (user == null && toUnauth) {
        return null;
      }

      if (user == null && !toUnauth) {
        return RoutesName.signin.path;
      }

      if (user != null && toUnauth) {
        return RoutesName.home.path;
      }

      if (user != null && !toUnauth) {
        return null;
      }

      return null;
    },
  );
}

class GoRouterRefreshListenable extends ChangeNotifier {
  GoRouterRefreshListenable(Stream stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (_) {
        notifyListeners();
      },
    );
  }

  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
