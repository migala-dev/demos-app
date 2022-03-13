import 'package:demos_app/core/models/manifesto/proposal/proposal_participation.model.dart';

class ProposalParticipationResponse {
  final ProposalParticipation proposalParticipation;

  ProposalParticipationResponse(
    this.proposalParticipation
  );

  factory ProposalParticipationResponse.fromObject(dynamic o) => ProposalParticipationResponse(
        ProposalParticipation.fromObject(o['proposalParticipation']),
      );
}
