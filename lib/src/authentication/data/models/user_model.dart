import 'dart:convert';

import 'package:repege/core/utils/typedefs.dart';
import 'package:repege/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.email,
    super.avatarURL,
    required super.emailVerified,
    required super.username,
  });

  UserModel copyWith({
    String? username,
    String? id,
    String? email,
    bool? emailVerified,
    String? avatarURL,
    DateTime? createdAt,
    String? displayName,
    String? phoneNumber,
  }) {
    return UserModel(
      username: username ?? this.username,
      id: id ?? this.id,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      avatarURL: avatarURL ?? this.avatarURL,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'username': username,
      'id': id,
      'email': email,
      'emailVerified': emailVerified,
      'avatarURL': avatarURL,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      username: map['username'] as String,
      id: map['id'] as String,
      email: map['email'] as String,
      emailVerified: map['emailVerified'] as bool,
      avatarURL: map['avatarURL'] != null ? map['avatarURL'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  factory UserModel.empty() {
    return UserModel(
      username: 'Usuário',
      id: '0',
      email: '',
      emailVerified: false,
      avatarURL: '',
      createdAt: DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as DataMap);
}
