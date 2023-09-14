import 'package:repege/modules/auth/models/auth_state.dart';

enum RoutesName {
  signin(state: AuthState.unauth, name: 'signin', path: '/signin'),
  signup(state: AuthState.unauth, name: 'signup', path: '/signup'),

  home(name: 'home', path: '/'),
  profile(name: 'profile', path: '/profile'),

  sheets(name: 'sheets', path: '/sheets'),
  sheet(name: 'sheet', path: 'sheet'),
  sheetCreate(name: 'sheet-create', path: 'create'),

  spells(name: 'spells', path: '/spells'),
  spellsSearch(name: 'spells-search', path: 'search'),
  spellDetails(name: 'spell-details', path: 'details'),

  equipments(name: 'equipments', path: '/equipments'),
  equipmentsSearch(name: 'equipments-search', path: 'search'),
  equipmentsDetails(name: 'equipments-details', path: 'details'),
  equipmentsForm(name: 'equipments-form', path: 'form'),

  tables(name: 'tables', path: '/tables'),
  tablesCreate(name: 'tables-create', path: 'create'),
  loading(name: 'loading', path: '/loading');

  const RoutesName({
    this.state = AuthState.auth,
    required this.name,
    required this.path,
  });

  final AuthState state;
  final String name;
  final String path;
}
