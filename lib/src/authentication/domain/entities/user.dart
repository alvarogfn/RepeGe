import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String id;
  final String email;
  final bool emailVerified;
  final String? avatarURL;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.createdAt,
    required this.email,
    required this.avatarURL,
    required this.emailVerified,
    required this.username,
  });

  @override
  List<Object> get props => [id];
}
