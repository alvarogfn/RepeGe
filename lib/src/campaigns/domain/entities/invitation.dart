import 'package:equatable/equatable.dart';

abstract class Invitation extends Equatable {
  final String guest;
  final String inviter;
  final String id;
  final String campaignId;
  final DateTime createdAt;
  final bool accepted;
  final bool pending;

  const Invitation({
    required this.guest,
    required this.inviter,
    required this.id,
    required this.campaignId,
    required this.createdAt,
    required this.accepted,
    required this.pending,
  });

  Invitation copyWith({
    String? guest,
    String? inviter,
    String? id,
    String? campaignId,
    DateTime? createdAt,
    bool? accepted,
    bool? pending,
  });

  Map<String, dynamic> toMap();

  String toJson();

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
