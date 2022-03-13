import 'package:demos_app/core/models/manifesto/proposal/proposal_participation.model.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal_participation.repository.dart';

class ProposalParticipationService {
  Future<ProposalParticipation?> findProposalParticipationByMemberId(String memberId, String proposalId) async {

    ProposalParticipation? participation = await ProposalParticipationRepository().findByMemberIdAndProposalId(memberId, proposalId);

    return participation;
  }
}
