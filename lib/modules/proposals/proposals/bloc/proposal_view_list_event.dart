part of 'proposal_view_list_bloc.dart';

abstract class ProposalViewListEvent extends Equatable {
  const ProposalViewListEvent();

  @override
  List<Object> get props => [];
}

class ProposalViewListLoaded extends ProposalViewListEvent {
  final String spaceId;

  const ProposalViewListLoaded(this.spaceId);

  @override
  List<Object> get props => [spaceId];
}

class ProposalViewListNewOptionSelected extends ProposalViewListEvent {
  final String spaceId;
  final ProposalListType type;

  const ProposalViewListNewOptionSelected(this.spaceId, this.type);

  @override
  List<Object> get props => [spaceId, type];
}
