import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repege/src/campaigns/data/model/act_model.dart';
import 'package:repege/src/campaigns/presentation/views/act_form_screen.dart';
import 'package:repege/src/campaigns/presentation/views/campaign_create_screen.dart';
import 'package:repege/src/campaigns/presentation/views/campaign_screen.dart';
import 'package:repege/src/campaigns/presentation/views/campaigns_screen.dart';
import 'package:repege/src/campaigns/presentation/views/invite_new_player_screen.dart';
import 'package:repege/src/campaigns/presentation/views/invitation_screen.dart';
import 'package:repege/src/equipments/presentation/views/equipment_form_screen.dart';
import 'package:repege/src/sheets/data/models/spell_model.dart';
import 'package:repege/src/sheets/presentation/views/sheet_create_screen.dart';
import 'package:repege/core/config/environment_variables.dart';
import 'package:repege/core/routes/routes_name.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/authentication/presentation/views/forgot_password_screen.dart';
import 'package:repege/src/authentication/presentation/views/signin_screen.dart';
import 'package:repege/src/authentication/presentation/views/signup_screen.dart';
import 'package:repege/src/miscellaneous/presentation/views/home_screen.dart';
import 'package:repege/src/sheets/presentation/views/sheet_screen.dart';
import 'package:repege/src/sheets/presentation/views/sheets_screen.dart';
import 'package:repege/src/spells/presentation/views/spell_details_screen.dart';
import 'package:repege/src/spells/presentation/views/spell_form_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final sheetsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'sheets');
final sheetNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'sheet');

final GoRouter routes = GoRouter(
  debugLogDiagnostics: !EnvironmentVariables.production,
  initialLocation: Routes.signin.path,
  refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.signin.path,
      name: Routes.signin.name,
      builder: (context, state) => const SigninScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.signup.path,
      name: Routes.signup.name,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.forgotPassword.path,
      name: Routes.forgotPassword.name,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.loading.path,
      name: Routes.loading.name,
      builder: (context, state) => const Scaffold(body: Center(child: CircularProgressIndicator())),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.home.path,
      name: Routes.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.equipment.path,
      name: Routes.equipment.name,
      builder: (context, state) => const Scaffold(),
      routes: [
        GoRoute(
          path: Routes.equipmentForm.path,
          name: Routes.equipmentForm.name,
          builder: (context, state) => const EquipmentFormScreen(),
        ),
      ],
    ),
    GoRoute(
      path: Routes.spell.path,
      name: Routes.spell.name,
      builder: (context, state) => const Scaffold(),
      routes: [
        GoRoute(
          path: Routes.spellsForm.path,
          name: Routes.spellsForm.name,
          builder: (context, state) => const SpellFormScreen(),
        ),
        GoRoute(
          path: Routes.spellsDetails.path,
          name: Routes.spellsDetails.name,
          builder: (context, state) => SpellDetailsScreen(state.extra as SpellModel),
        )
      ],
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.sheets.path,
      name: Routes.sheets.name,
      builder: (context, state) => const SheetsScreen(),
      routes: [
        GoRoute(
          path: Routes.sheetCreate.path,
          name: Routes.sheetCreate.name,
          builder: (context, state) => const SheetsCreateScreen(),
        ),
        GoRoute(
          path: Routes.sheet.path,
          name: Routes.sheet.name,
          builder: (context, state) => SheetScreen(state.pathParameters['id'] as String),
        ),
      ],
    ),
    GoRoute(
      path: Routes.invites.path,
      name: Routes.invites.name,
      builder: (context, state) => const InvitationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.campaigns.path,
      name: Routes.campaigns.name,
      builder: (context, state) => const CampaignsScreen(),
      routes: [
        GoRoute(
          path: Routes.campaignsCreate.path,
          name: Routes.campaignsCreate.name,
          builder: (context, state) => const CampaignCreateScreen(),
        ),
        GoRoute(
          path: Routes.campaign.path,
          name: Routes.campaign.name,
          builder: (context, state) => CampaignScreen(state.pathParameters['id'] as String),
          routes: [
            GoRoute(
              path: Routes.campaignInvite.path,
              name: Routes.campaignInvite.name,
              builder: (context, state) => const InviteNewPlayerScreen(),
            ),
            GoRoute(
              path: Routes.acts.name,
              name: Routes.acts.path,
              builder: (context, state) => const Scaffold(),
              routes: [
                GoRoute(
                  path: Routes.actsForm.path,
                  name: Routes.actsForm.name,
                  builder: (context, state) => ActFormScreen(
                    act: state.extra as ActModel?,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: (context, state) async {
    // ignore: avoid_print
    if (!EnvironmentVariables.production) print('refreshing');

    final bool toUnauth = Routes.values
        .where((element) => element.state == AuthState.unauth)
        .map((e) => e.path)
        .contains(state.matchedLocation);

    final authState = context.read<AuthenticationCubit>().state;

    final isAuth = authState is Authenticated && authState.user.emailVerified;

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
