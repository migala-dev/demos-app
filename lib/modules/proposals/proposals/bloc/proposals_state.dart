part of 'proposals_bloc.dart';

abstract class ProposalsState extends Equatable {
  const ProposalsState();

  @override
  List<Object> get props => [];
}

class ProposalsLoadingInProgress extends ProposalsState {}

class ProposalsStateWithData extends ProposalsState {
  final List<Manifesto> proposals;
  final ProposalListType type;

  const ProposalsStateWithData(this.proposals, this.type);

  @override
  List<Object> get props => [proposals, type];
}
