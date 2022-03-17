/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

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
        .update(response.proposalParticipation);
  }

  Future<void> voteManifestoOption(
      String spaceId, String proposalId, String manifestoOptionId) async {
    String userHash = await generateUserHash(proposalId);

    VoteProposalResponse response = await ProposalApi()
        .voteManifestoOptionProposal(
            spaceId, proposalId, userHash, manifestoOptionId);

    await ProposalParticipationRepository()
        .update(response.proposalParticipation);
  }

  Future<void> voteNull(String spaceId, String proposalId, String nullVoteComment) async {
     String userHash = await generateUserHash(proposalId);

    VoteProposalResponse response = await ProposalApi()
        .voteNullProposal(
            spaceId, proposalId, userHash, nullVoteComment);

    await ProposalParticipationRepository()
        .update(response.proposalParticipation);
  }
}
