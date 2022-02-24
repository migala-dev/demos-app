import 'package:demos_app/core/models/manifesto/proposal/proposal_participation.model.dart';

class VoteProposalResponse {
  final ProposalParticipation proposalParticipation;

  VoteProposalResponse(this.proposalParticipation);

  factory VoteProposalResponse.fromObject(dynamic o) =>
      VoteProposalResponse(ProposalParticipation.fromObject(o['proposalParticipation']));
}
