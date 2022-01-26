import 'package:demos_app/modules/proposals/pages/proposals/enums/proposal_list_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:equatable/equatable.dart';

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
