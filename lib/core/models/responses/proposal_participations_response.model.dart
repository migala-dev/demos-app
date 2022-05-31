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

import 'package:demos_app/core/models/manifesto/proposal/proposal.model.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal_participation.model.dart';

class ProposalParticipationsResponse {
  final Proposal proposal;
  final List<ProposalParticipation> participations;

  ProposalParticipationsResponse(
    this.proposal,
    this.participations,
  );

  factory ProposalParticipationsResponse.fromObject(dynamic o) =>
      ProposalParticipationsResponse(
        Proposal.fromObject(o['proposal']),
        o['participations'] != null
            ? (o['participations'] as List<dynamic>)
                .map((participation) =>
                    ProposalParticipation.fromObject(participation))
                .toList()
            : [],
      );
}
