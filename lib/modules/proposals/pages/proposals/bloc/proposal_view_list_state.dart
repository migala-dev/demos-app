import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';
import 'package:equatable/equatable.dart';

abstract class ProposalViewListState extends Equatable {
  const ProposalViewListState();

  @override
  List<Object> get props => [];
}

class ProposalViewListLoadingInProgress extends ProposalViewListState {}

class ProposalViewListEmpty extends ProposalViewListState {}

class ProposalViewListWithData extends ProposalViewListState {
  final ProposalViewList proposalViewList;

  const ProposalViewListWithData(this.proposalViewList);

  @override
  List<Object> get props => [proposalViewList];
}
