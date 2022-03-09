import 'package:demos_app/core/api/proposal.api.dart';
import 'package:demos_app/core/models/responses/vote_proposal_response.model.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal_participation.repository.dart';
import 'package:demos_app/utils/generate_user_hash.util.dart';

class ProposalVoteService {
  Future<void> voteInFavor(
      String spaceId, String proposalId, bool inFavor) async {
    String userHash = await generateUserHash(proposalId);

    VoteProposalResponse response = await ProposalApi()
        .voteInFavorProposal(spaceId, proposalId, userHash, inFavor);

    await ProposalParticipationRepository()
        .insert(response.proposalParticipation);
  }

  Future<void> voteManifestoOption(
      String spaceId, String proposalId, String manifestoOptionId) async {
    String userHash = await generateUserHash(proposalId);

    VoteProposalResponse response = await ProposalApi()
        .voteManifestoOptionProposal(
            spaceId, proposalId, userHash, manifestoOptionId);

    await ProposalParticipationRepository()
        .insert(response.proposalParticipation);
  }

  Future<void> voteNull(String spaceId, String proposalId, String nullVoteComment) async {
     String userHash = await generateUserHash(proposalId);

    VoteProposalResponse response = await ProposalApi()
        .voteNullProposal(
            spaceId, proposalId, userHash, nullVoteComment);

    await ProposalParticipationRepository()
        .insert(response.proposalParticipation);
  }
}
