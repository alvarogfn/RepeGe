import "package:repege/domains/authentication/services/auth_state.dart";

enum RoutesName {
  signin(state: AuthState.unauth, name: "signin", path: "/signin"),
  signup(state: AuthState.unauth, name: "signup", path: "/signup"),

  home(name: "home", path: "/"),
  profile(name: "profile", path: "profile"),

  sheets(name: "sheets", path: "/sheets"),

  sheet(name: "sheet", path: "sheet/:id"),

  sheetSpellCreate(name: "sheet-spell-create", path: "spell-create"),
  sheetSpellSearch(name: "sheet-spell-search", path: "spell-search"),
  sheetCreate(name: "sheet-create", path: "create"),

  spellDetails(name: "spell-details", path: "spell-details"),

  tables(name: "tables", path: "/tables"),
  loading(name: "loading", path: "/loading");

  const RoutesName({
    this.state = AuthState.auth,
    required this.name,
    required this.path,
  });

  final AuthState state;
  final String name;
  final String path;
}
