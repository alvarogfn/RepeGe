import 'package:equatable/equatable.dart';

abstract class Invitation extends Equatable {
  final String guest;
  final String inviter;
  final String id;
  final String campaignId;
  final String? sheetId;
  final DateTime createdAt;
  final bool accepted;
  final bool pending;

  const Invitation({
    this.sheetId,
    required this.guest,
    required this.inviter,
    required this.id,
    required this.campaignId,
    required this.createdAt,
    required this.accepted,
    required this.pending,
  });

  Invitation copyWith({
    String? sheetId,
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
      sheetId ?? '',
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
