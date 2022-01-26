import 'package:demos_app/modules/proposals/pages/proposals/enums/proposal_list_type.enum.dart';
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
  final ProposalListType type;

  const ProposalViewListNewOptionSelected(this.spaceId, this.type);

  @override
  List<Object> get props => [spaceId, type];
}
