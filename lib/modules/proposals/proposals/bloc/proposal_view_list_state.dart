part of 'proposal_view_list_bloc.dart';

abstract class ProposalViewListState extends Equatable {
  const ProposalViewListState();

  @override
  List<Object> get props => [];
}

class ProposalViewListLoadingInProgress extends ProposalViewListState {}

class ProposalViewListEmpty extends ProposalViewListState {}

class ProposalViewListWithData extends ProposalViewListState {
  final List<ProposalView> proposals;
  final ProposalListType type;

  const ProposalViewListWithData(this.proposals, this.type);

  @override
  List<Object> get props => [proposals, type];
}
