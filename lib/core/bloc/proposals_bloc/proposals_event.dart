part of 'proposals_bloc.dart';

abstract class ProposalsEvent extends Equatable {
  const ProposalsEvent();

  @override
  List<Object> get props => [];
}

class ProposalEventInitialized extends ProposalsEvent {
  final String spaceId;

  const ProposalEventInitialized(this.spaceId);

  @override
  List<Object> get props => [spaceId];
}
