part of 'proposals_bloc.dart';

abstract class ProposalsState extends Equatable {
  const ProposalsState();

  @override
  List<Object> get props => [];
}

class ProposalLoadingInProgress extends ProposalsState {}

class ProposalBlocStateWithData extends ProposalsState {
  final List<Manifesto> proposals;
  final ProposalListType type;

  const ProposalBlocStateWithData(this.proposals, this.type);

  @override
  List<Object> get props => [proposals, type];
}
