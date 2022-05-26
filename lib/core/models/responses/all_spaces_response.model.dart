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
  late List<Space> _spaces;
  late List<Member> _members;
  late List<User> _users;
  late List<Proposal> _proposals;
  late List<ProposalParticipation> _proposalParticipations;
  late List<ProposalVote> _proposalVotes;
  late List<Manifesto> _manifestos;
  late List<ManifestoOption> _manifestoOptions;
  late List<ManifestoComment> _manifestoComments;
  late List<ManifestoCommentVote> _manifestoCommentVotes;

  List<Space> get spaces => _spaces;
  List<Member> get members => _members;
  List<User> get users => _users;
  List<Proposal> get proposals => _proposals;
  List<ProposalParticipation> get proposalParticipations => _proposalParticipations;
  List<ProposalVote> get proposalVotes => _proposalVotes;
  List<Manifesto> get manifestos => _manifestos;
  List<ManifestoOption> get manifestoOptions => _manifestoOptions;
  List<ManifestoComment> get manifestoComments => _manifestoComments;
  List<ManifestoCommentVote> get manifestoCommentVotes => _manifestoCommentVotes;

  AllSpacesResponse.fromObject(dynamic o) {
    List<dynamic> spacesResponse = o['spaces'];
    _spaces = spacesResponse.map((s) => Space.fromObject(s)).toList();

    List<dynamic> membersResponse = o['members'];
    _members = membersResponse.map((s) => Member.fromObject(s)).toList();

    List<dynamic> usersResponse = o['users'];
    _users = usersResponse.map((m) => User.fromObject(m)).toList();

    List<dynamic> proposalsResponse = o['proposals'];
    _proposals = proposalsResponse.map((p) => Proposal.fromObject(p)).toList();

    List<dynamic> proposalParticipationsResponse = o['proposalParticipations'];
    _proposalParticipations = proposalParticipationsResponse.map((p) => ProposalParticipation.fromObject(p)).toList();

    List<dynamic> proposalVotesResponse = o['proposalVotes'];
    _proposalVotes = proposalVotesResponse.map((v) => ProposalVote.fromObject(v)).toList();

    List<dynamic> manifestosResponse = o['manifestos'];
    _manifestos = manifestosResponse.map((m) => Manifesto.fromObject(m)).toList();

    List<dynamic> manifestoOptionsResponse = o['manifestoOptions'];
    _manifestoOptions = manifestoOptionsResponse.map((o) => ManifestoOption.fromObject(o)).toList();

    List<dynamic> manifestoCommentsResponse = o['manifestoComments'];
    _manifestoComments = manifestoCommentsResponse.map((c) => ManifestoComment.fromObject(c)).toList();

    List<dynamic> manifestoCommentVotesResponse = o['manifestoCommentVotes'];
    _manifestoCommentVotes = manifestoCommentVotesResponse.map((v) => ManifestoCommentVote.fromObject(v)).toList();

  }
}
