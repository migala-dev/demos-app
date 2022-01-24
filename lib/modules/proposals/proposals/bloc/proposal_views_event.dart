part of 'proposal_views_bloc.dart';

abstract class ProposalViewsEvent extends Equatable {
  const ProposalViewsEvent();

  @override
  List<Object> get props => [];
}

class ProposalViewsLoaded extends ProposalViewsEvent {
  final String spaceId;

  const ProposalViewsLoaded(this.spaceId);

  @override
  List<Object> get props => [spaceId];
}

class ProposalViewsNewOptionSelected extends ProposalViewsEvent {
  final String spaceId;
  final ProposalListType type;

  const ProposalViewsNewOptionSelected(this.spaceId, this.type);

  @override
  List<Object> get props => [spaceId, type];
}
