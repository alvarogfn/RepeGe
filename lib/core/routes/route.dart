// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:repege/config/routes_name.dart';
// import 'package:repege/config/stream_auth_scope.dart';

// import 'package:repege/modules/auth/screens/signin_screen.dart';
// import 'package:repege/modules/auth/screens/signup_screen.dart';

// import 'package:repege/modules/auth/models/auth_state.dart';
// import 'package:repege/modules/campaign/screens/campaign_create_screen.dart';
// import 'package:repege/modules/campaign/screens/campaign_screen.dart';
// import 'package:repege/modules/equipments/models/equipment.dart';
// import 'package:repege/modules/equipments/screens/equipment_screen.dart';
// import 'package:repege/modules/equipments/screens/equipment_create_screen.dart';
// import 'package:repege/modules/equipments/screens/equipment_search_screen.dart';
// import 'package:repege/modules/invitations/invitation_sheet_choose_screen.dart';
// import 'package:repege/modules/invitations/invitations_screen.dart';
// import 'package:repege/modules/sheet/sheet_screen.dart';
// import 'package:repege/modules/sheets/screens/sheets_create_screen.dart';
// import 'package:repege/modules/sheets/screens/sheets_screen.dart';
// import 'package:repege/modules/spell/models/spell.dart';
// import 'package:repege/modules/spell/screens/spell_details_screen.dart';
// import 'package:repege/modules/spell/screens/spell_form_screen.dart';
// import 'package:repege/modules/spell/screens/spell_search_screen.dart';
// import 'package:repege/modules/campaigns/screens/campaigns_screen.dart';
// import 'package:repege/modules/profile/screens/profile_screen.dart';
// import 'package:repege/modules/user/screens/home_screen.dart';
// import 'package:repege/screens/loading_page.dart';
// import 'package:repege/config/environment_variables.dart';

// class CustomRouter {
//   final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

//   CustomRouter();

//   late final routes = GoRouter( 
//     debugLogDiagnostics: !EnvironmentVariables.production,
//     initialLocation: '/',
//     navigatorKey: _rootNavigatorKey,
//     routes: [
//       GoRoute(
//         path: RoutesName.home.path,
//         name: RoutesName.home.name,
//         builder: (context, state) => const HomeScreen(),
//         routes: const [],
//       ),
//       GoRoute(
//         path: RoutesName.signin.path,
//         name: RoutesName.signin.name,
//         builder: (context, state) => const SigninScreen(),
//       ),
//       GoRoute(
//         path: RoutesName.signup.path,
//         name: RoutesName.signup.name,
//         builder: (context, state) => const SignupScreen(),
//       ),
//       GoRoute(
//         path: RoutesName.loading.path,
//         name: RoutesName.loading.name,
//         builder: (context, state) => const LoadingPage(),
//       ),
//       GoRoute(
//         builder: (context, state) => const ProfileScreen(),
//         name: RoutesName.profile.name,
//         path: RoutesName.profile.path,
//       ),
//       GoRoute(
//         builder: (context, state) => const SheetsScreen(),
//         name: RoutesName.sheets.name,
//         path: RoutesName.sheets.path,
//         routes: [
//           GoRoute(
//             builder: (context, state) => const SheetsCreateScreen(),
//             path: RoutesName.sheetCreate.path,
//             name: RoutesName.sheetCreate.name,
//           ),
//           GoRoute(
//             path: RoutesName.sheet.path,
//             name: RoutesName.sheet.name,
//             builder: (context, state) => SheetScreen(state.pathParameters['id'] as String),
//           )
//         ],
//       ),
//       GoRoute(
//         builder: (context, state) => SpellDetailsScreen(state.extra as Spell),
//         name: RoutesName.spell.name,
//         path: RoutesName.spell.path,
//       ),
//       GoRoute(
//         builder: (context, state) => const SpellSearchScreen(),
//         path: RoutesName.spellsSearch.path,
//         name: RoutesName.spellsSearch.name,
//       ),
//       GoRoute(
//         builder: (context, state) => const SpellFormScreen(),
//         path: RoutesName.spellsForm.path,
//         name: RoutesName.spellsForm.name,
//       ),
//       GoRoute(
//         builder: (context, state) => const EquipmentScreen(),
//         name: RoutesName.equipments.name,
//         path: RoutesName.equipments.path,
//         routes: [
//           GoRoute(
//             builder: (context, state) => const EquipmentSearchScreen(),
//             path: RoutesName.equipmentsSearch.path,
//             name: RoutesName.equipmentsSearch.name,
//           ),
//           GoRoute(
//             builder: (context, state) => EquipmentCreateScreen(
//               state.extra as Equipment?,
//             ),
//             path: RoutesName.equipmentsForm.path,
//             name: RoutesName.equipmentsForm.name,
//           ),
//         ],
//       ),
//       GoRoute(
//         path: RoutesName.campaigns.path,
//         name: RoutesName.campaigns.name,
//         builder: (context, state) => const CampaingsScreen(),
//         routes: [
//           GoRoute(
//             path: RoutesName.campaignsCreate.path,
//             name: RoutesName.campaignsCreate.name,
//             builder: (context, state) => const CampaignCreateScreen(),
//           ),
//         ],
//       ),
//       GoRoute(
//         path: RoutesName.campaign.path,
//         name: RoutesName.campaign.name,
//         builder: (context, state) =>  CampaignScreen(state.pathParameters['id'] as String),
//       ),
//       GoRoute(
//         path: RoutesName.invitations.path,
//         name: RoutesName.invitations.name,
//         builder: (context, state) => const InvitationsScreen(),
//         routes: [
//           GoRoute(
//             path: RoutesName.invitationsSheetChoose.path,
//             name: RoutesName.invitationsSheetChoose.name,
//             builder: (context, state) => const InvitationSheetChooseScreen(),
//           )
//         ],
//       )
//     ],
//     redirect: (context, state) async {
//       final bool toUnauth = RoutesName.values
//           .where((element) => element.state == AuthState.unauth)
//           .map((e) => e.path)
//           .contains(state.matchedLocation);

//       final user = StreamAuthScope.of(context).currentUser;

//       if (user == null && toUnauth) {
//         return null;
//       }

//       if (user == null && !toUnauth) {
//         return RoutesName.signin.path;
//       }

//       if (user != null && toUnauth) {
//         return RoutesName.home.path;
//       }

//       if (user != null && !toUnauth) {
//         return null;
//       }

//       return null;
//     },
//   );
// }
