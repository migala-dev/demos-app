import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';

abstract class ProposalDetailsEvent {}

class SetProposalViewEvent extends ProposalDetailsEvent {
  ProposalView proposalView;

  SetProposalViewEvent(this.proposalView);
}
