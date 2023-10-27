import 'dart:convert';
import 'package:repege/src/campaigns/domain/entities/invitation.dart';

class InvitationModel extends Invitation {
  const InvitationModel({
    required super.guest,
    required super.inviter,
    required super.id,
    required super.campaignId,
    required super.createdAt,
    required super.accepted,
    required super.pending,
  });

  @override
  Invitation copyWith({
    String? guest,
    String? inviter,
    String? id,
    String? campaignId,
    DateTime? createdAt,
    bool? accepted,
    bool? pending,
  }) {
    return InvitationModel(
      guest: guest ?? this.guest,
      inviter: inviter ?? this.inviter,
      id: id ?? this.id,
      campaignId: campaignId ?? this.campaignId,
      createdAt: createdAt ?? this.createdAt,
      accepted: accepted ?? this.accepted,
      pending: pending ?? this.pending,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'guest': guest,
      'inviter': inviter,
      'id': id,
      'campaignId': campaignId,
      'createdAt': createdAt,
      'accepted': accepted,
      'pending': pending,
    };
  }

  factory InvitationModel.fromMap(Map<String, dynamic> map) {
    return InvitationModel(
      guest: map['guest'] as String,
      inviter: map['inviter'] as String,
      id: map['id'] as String,
      campaignId: map['campaignId'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      accepted: map['accepted'] as bool,
      pending: map['pending'] as bool,
    );
  }

  factory InvitationModel.empty() {
    return InvitationModel(
      guest: '',
      inviter: '',
      id: '',
      campaignId: '',
      createdAt: DateTime.now(),
      accepted: false,
      pending: false,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory InvitationModel.fromJson(String source) => InvitationModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      guest,
      inviter,
      id,
      campaignId,
      createdAt,
      accepted,
      pending,
    ];
  }
}
