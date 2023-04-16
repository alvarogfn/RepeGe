class LoggedUser {
  final String uid;
  final String email;

  LoggedUser({
    required this.uid,
    required this.email,
  });
}

class LoggedUserWithData extends LoggedUser {
  final String avatar;
  final String username;

  LoggedUserWithData({
    required this.avatar,
    required this.username,
    required super.uid,
    required super.email,
  });
}
