
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';
import 'package:equatable/equatable.dart';

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
  final ProposalViewList proposalViewList;

  const ProposalViewListNewOptionSelected(this.spaceId, this.proposalViewList);

  @override
  List<Object> get props => [spaceId, proposalViewList];
}
