import 'package:repege/modules/auth/models/auth_state.dart';

enum RoutesName {
  signin(state: AuthState.unauth, name: 'signin', path: '/signin'),
  signup(state: AuthState.unauth, name: 'signup', path: '/signup'),

  home(name: 'home', path: '/'),
  profile(name: 'profile', path: '/profile'),

  sheets(name: 'sheets', path: '/sheets'),
  sheet(name: 'sheet', path: ':id'),
  sheetCreate(name: 'sheet-create', path: 'create'),

  spell(name: 'spell', path: '/spell/:id'),
  spellsSearch(name: 'spells-search', path: '/spells/search'),
  spellsForm(name: 'spells-form', path: '/spells/form'),

  equipments(name: 'equipments', path: '/equipments'),
  equipmentsSearch(name: 'equipments-search', path: 'search'),
  equipmentsDetails(name: 'equipments-details', path: 'details'),
  equipmentsForm(name: 'equipments-form', path: 'form'),

  campaigns(name: 'campaigns', path: '/campaigns'),
  campaignsCreate(name: 'campaigns-create', path: 'create'),
  campaign(name: 'campaign', path: ':id'),

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
