// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as DataMap);

  factory UserModel.fromFirebase(DocumentSnapshot<Map> snapshot) {
    final map = snapshot.data()!;

    if (map['createdAt'] == null) {
      map.update('createdAt', (value) => DateTime.now());
    }

    return UserModel(
      id: map['id'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      email: map['email'],
      emailVerified: map['emailVerified'],
      username: map['username'],
      avatarURL: map['avatarURL'],
    );
  }
}
