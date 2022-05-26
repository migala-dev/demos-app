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

import 'package:demos_app/core/api/space.api.dart';
import 'package:demos_app/core/models/responses/all_spaces_response.model.dart';
import 'package:demos_app/core/models/responses/space_response.model.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/repositories/manifesto/comment/manifesto_comment.repository.dart';
import 'package:demos_app/core/repositories/manifesto/comment/manifesto_comment_vote.repository.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto_option.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal_participation.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal_vote.repository.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/core/repositories/members.repository.dart';
import 'package:demos_app/core/repositories/users.repository.dart';

import 'cache.service.dart';

class GeneralSpaceService {
  Future<void> getUserSpaces() async {
    List<Space> spaces = await SpacesRepository().getAll();
    if (spaces.isEmpty) {
      AllSpacesResponse response = await SpaceApi().getAllSpaces();

      for (final space in response.spaces) {
        await SpacesRepository().insert(space);
      }

      for (final member in response.members) {
        await MembersRepository().insert(member);
      }

      for (final user in response.users) {
        await UsersRepository().insertOrUpdate(user);
      }

      for (final proposal in response.proposals) {
        await ProposalRepository().insertOrUpdate(proposal);
      }

      for (final proposalParticipation in response.proposalParticipations) {
        await ProposalParticipationRepository().insertOrUpdate(proposalParticipation);
      }

      for (final propsalVote in response.proposalVotes) {
        await ProposalVoteRepository().insert(propsalVote);
      }

      for (final manifesto in response.manifestos) {
        await ManifestoRepository().insertOrUpdate(manifesto);
      }

      for (final manifestoOption in response.manifestoOptions) {
        await ManifestoOptionRepository().insertOrUpdate(manifestoOption);
      }

      for (final manifestoComment in response.manifestoComments) {
        await ManifestoCommentRepository().insertOrUpdate(manifestoComment);
      }

      for (final manifestoCommentVote in response.manifestoCommentVotes) {
        await ManifestoCommentVoteRepository().insertOrUpdate(manifestoCommentVote);
      }

      await CacheService().updateLastUpdatedDate();
    }
  }

  Future<Space> updateSpace(String spaceId) async {
    SpaceResponse response = await SpaceApi().getSpace(spaceId);
    await SpacesRepository().updateSpace(response.space);

    return response.space;
  }
}
