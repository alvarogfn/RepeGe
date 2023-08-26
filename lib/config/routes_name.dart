import 'package:repege/modules/authentication/models/auth_state.dart';

enum RoutesName {
  signin(state: AuthState.unauth, name: 'signin', path: '/signin'),
  signup(state: AuthState.unauth, name: 'signup', path: '/signup'),

  home(name: 'home', path: '/'),
  profile(name: 'profile', path: '/profile'),

  sheets(name: 'sheets', path: '/sheets'),
  sheet(name: 'sheet', path: ':id'),
  sheetCreate(name: 'sheet-create', path: 'create'),

  spells(name: 'spell', path: '/spells'),
  spellsSearch(name: 'spells-search', path: 'search'),
  spellDetails(name: 'spell-details', path: 'details'),

  tables(name: 'tables', path: '/tables'),
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
