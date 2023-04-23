class LoggedUser {
  final String uid;
  final String email;

  LoggedUser({
    required this.uid,
    required this.email,
  });

  factory LoggedUser.fromMap(Map<String, dynamic> data) {
    return LoggedUser(
      uid: data['uid'],
      email: data['email'],
    );
  }
}

class LoggedUserWithData extends LoggedUser {
  final String avatarURL;
  final String username;

  LoggedUserWithData({
    required this.avatarURL,
    required this.username,
    required super.uid,
    required super.email,
  });

  factory LoggedUserWithData.fromMap(Map<String, dynamic> data) {
    return LoggedUserWithData(
      avatarURL: data['avatarURL'],
      username: data['username'],
      uid: data['uid'],
      email: data['email'],
    );
  }
}
