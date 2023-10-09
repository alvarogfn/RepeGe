enum AuthState { unauth, auth }

enum Routes {
  signin(state: AuthState.unauth, name: 'signin', path: '/signin'),
  signup(state: AuthState.unauth, name: 'signup', path: '/signup'),
  forgotPassword(state: AuthState.unauth, name: 'forgot-password', path: '/forgot-password'),

  home(name: 'home', path: '/'),

  sheets(name: 'sheets', path: '/sheets'),
  sheetCreate(name: 'sheet-create', path: 'create'),
  sheet(name: 'sheet', path: 'sheet/:id'),

  // spell(name: 'spell', path: '/spell/:id'),
  // spellsSearch(name: 'spells-search', path: '/spells/search'),
  // spellsForm(name: 'spells-form', path: '/spells/form'),

  // equipments(name: 'equipments', path: '/equipments'),
  // equipmentsSearch(name: 'equipments-search', path: 'search'),
  // equipmentsDetails(name: 'equipments-details', path: 'details'),
  // equipmentsForm(name: 'equipments-form', path: 'form'),

  // campaigns(name: 'campaigns', path: '/campaigns'),
  // campaignsCreate(name: 'campaign-create', path: 'create'),
  // campaign(name: 'campaign', path: '/campaign/:id'),

  // invitations(name: 'invitations', path: '/invitations'),
  // invitationsSheetChoose(name: 'invitations-sheet-choose', path: 'sheet-choose'),

  loading(name: 'loading', path: '/loading');

  const Routes({
    this.state = AuthState.auth,
    required this.name,
    required this.path,
  });

  final AuthState state;
  final String name;
  final String path;
}
