part of 'proposal_views_bloc.dart';

abstract class ProposalViewsEvent extends Equatable {
  const ProposalViewsEvent();

  @override
  List<Object> get props => [];
}

class ProposalViewsInitialized extends ProposalViewsEvent {
  final String spaceId;

  const ProposalViewsInitialized(this.spaceId);

  @override
  List<Object> get props => [spaceId];
}

class ProposalViewsLoaded extends ProposalViewsEvent {
  final String spaceId;
  final ProposalListType type;

  const ProposalViewsLoaded(this.spaceId, this.type);

  @override
  List<Object> get props => [spaceId, type];
}
