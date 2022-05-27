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

import 'package:demos_app/core/models/manifesto/comment/manifesto_comment.model.dart';
import 'package:demos_app/core/models/manifesto/comment/manifesto_comment_vote.model.dart';
import 'package:demos_app/core/models/manifesto/manifesto.model.dart';
import 'package:demos_app/core/models/manifesto/manifesto_option.model.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal.model.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal_participation.model.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal_vote.model.dart';
import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/user.model.dart';

class AllSpacesResponse {
  final List<Space> spaces;
  final List<Member> members;
  final List<User> users;
  final List<Proposal> proposals;
  final List<ProposalParticipation> proposalParticipations;
  final List<ProposalVote> proposalVotes;
  final List<Manifesto> manifestos;
  final List<ManifestoOption> manifestoOptions;
  final List<ManifestoComment> manifestoComments;
  final List<ManifestoCommentVote> manifestoCommentVotes;

  AllSpacesResponse(
    this.spaces,
    this.members,
    this.users,
    this.proposals,
    this.proposalParticipations,
    this.proposalVotes,
    this.manifestos,
    this.manifestoOptions,
    this.manifestoComments,
    this.manifestoCommentVotes,
  );

  factory AllSpacesResponse.fromObject(dynamic o) =>  AllSpacesResponse(
     (o['spaces'] as List<dynamic>)
            .map((space) =>
                Space.fromObject(space))
            .toList(),
     (o['members'] as List<dynamic>)
            .map((member) =>
                Member.fromObject(member))
            .toList(),
     (o['users'] as List<dynamic>)
            .map((user) =>
                User.fromObject(user))
            .toList(),
     (o['proposals'] as List<dynamic>)
            .map((proposal) =>
                Proposal.fromObject(proposal))
            .toList(),
     (o['proposalParticipations'] as List<dynamic>)
            .map((proposalParticipation) =>
                ProposalParticipation.fromObject(proposalParticipation))
            .toList(),
     (o['proposalVotes'] as List<dynamic>)
            .map((proposalVote) =>
                ProposalVote.fromObject(proposalVote))
            .toList(),
     (o['manifestos'] as List<dynamic>)
            .map((manifesto) =>
                Manifesto.fromObject(manifesto))
            .toList(),
     (o['manifestoOptions'] as List<dynamic>)
            .map((manifestoOption) =>
                ManifestoOption.fromObject(manifestoOption))
            .toList(),
     (o['manifestoComments'] as List<dynamic>)
            .map((manifestoComment) =>
                ManifestoComment.fromObject(manifestoComment))
            .toList(),
     (o['manifestoCommentVotes'] as List<dynamic>)
            .map((manifestoCommentVote) =>
                ManifestoCommentVote.fromObject(manifestoCommentVote))
            .toList(),
      
  );
}
