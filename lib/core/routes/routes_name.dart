enum AuthState { unauth, auth }

enum Routes {
  signin(state: AuthState.unauth, name: 'signin', path: '/signin'),
  signup(state: AuthState.unauth, name: 'signup', path: '/signup'),
  forgotPassword(state: AuthState.unauth, name: 'forgot-password', path: '/forgot-password'),

  home(name: 'home', path: '/'),

  sheets(name: 'sheets', path: '/sheets'),
  sheetCreate(name: 'sheet-create', path: 'create'),
  sheet(name: 'sheet', path: 'sheet/:id'),
  sheetView(name: 'sheet-view', path: 'sheet/:id/view'),
  sheetSelect(name: 'sheet-select', path: ':createdBy'),

  spell(name: 'spell', path: '/spell'),
  spellsForm(name: 'spells-form', path: 'form'),
  spellsDetails(name: 'spells-details', path: 'details/:id'),

  equipment(name: 'equipment', path: '/equipment'),
  equipmentForm(name: 'equipment-form', path: 'form'),

  invites(name: 'invites', path: '/invites'),

  campaigns(name: 'campaigns', path: '/campaigns'),
  campaignsCreate(name: 'campaign-create', path: 'create'),
  campaign(name: 'campaign', path: 'campaign/:id'),
  campaignInvite(name: 'campaign-invite', path: 'invite'),
  acts(name: 'acts', path: 'acts'),
  actsForm(name: 'acts-form', path: 'form'),

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
