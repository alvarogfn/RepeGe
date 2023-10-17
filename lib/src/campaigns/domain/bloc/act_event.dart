// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'act_bloc.dart';

sealed class ActEvent extends Equatable {
  const ActEvent();

  @override
  List<Object> get props => [];
}

class ActInitEvent extends ActEvent {
  final String campaignId;

  const ActInitEvent({required this.campaignId});
}

class ActDeleteEvent extends ActEvent {
  final Act act;

  const ActDeleteEvent({required this.act});
}

class ActCreateOrUpdateActEvent extends ActEvent {
  final Act act;
  const ActCreateOrUpdateActEvent({
    required this.act,
  });

  @override
  List<Object> get props => act.props;
}
