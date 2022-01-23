part of 'proposal_views_bloc.dart';

abstract class ProposalViewsState extends Equatable {
  const ProposalViewsState();

  @override
  List<Object> get props => [];
}

class ProposalViewsLoadingInProgress extends ProposalViewsState {}

class ProposalsStateWithData extends ProposalViewsState {
  final List<ProposalView> proposals;
  final ProposalListType type;

  const ProposalsStateWithData(this.proposals, this.type);

  @override
  List<Object> get props => [proposals, type];
}
