part of 'proposals_bloc.dart';

abstract class ProposalsEvent extends Equatable {
  const ProposalsEvent();

  @override
  List<Object> get props => [];
}

class ProposalsInitialized extends ProposalsEvent {
  final String spaceId;

  const ProposalsInitialized(this.spaceId);

  @override
  List<Object> get props => [spaceId];
}

class ProposalsLoaded extends ProposalsEvent {
  final String spaceId;
  final ProposalListType type;

  const ProposalsLoaded(this.spaceId, this.type);

  @override
  List<Object> get props => [spaceId, type];
}
