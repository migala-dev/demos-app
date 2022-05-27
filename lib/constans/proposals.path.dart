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

import 'package:demos_app/enviroments/enviroment.interface.dart';
import 'package:demos_app/enviroments/get_enviroment.dart';

class ProposalsPath {
  String getProposalsPath() {
    final Enviroment enviroment = getEnviroment();
    return '${enviroment.manifestoServiceUrl}/proposals';
  }

  String getSpaceProposalsPath(String spaceId) =>
      '${getProposalsPath()}/$spaceId';

  String getDraftPath(String spaceId) =>
      '${getSpaceProposalsPath(spaceId)}/draft';

  String getProposalDraftPath(String spaceId, String proposalId) =>
      '${getSpaceProposalsPath(spaceId)}/draft/$proposalId';

  String getPublishDraftPath(String spaceId, String proposalId) =>
      '${getProposalDraftPath(spaceId, proposalId)}/publish';

  String getPublishPath(String spaceId) =>
      '${getSpaceProposalsPath(spaceId)}/publish';

  String getProposalPath(String spaceId, String proposalId) =>
      '${getSpaceProposalsPath(spaceId)}/$proposalId';

  String getProposalParticipationsPath(String spaceId, String proposalId) =>
      '${getProposalPath(spaceId, proposalId)}/participation';

  String getResetProposalParticipationPath(String spaceId, String proposalId) =>
      '${getProposalParticipationsPath(spaceId, proposalId)}/reset';

  String getProposalParticipationPath(String spaceId, String participationId) =>
      '${getSpaceProposalsPath(spaceId)}/participation/$participationId';

  String getCancelProposalPath(String spaceId, String proposalId) =>
      '${getProposalPath(spaceId, proposalId)}/cancel';

  String getVoteProposalPath(String spaceId, String proposalId) =>
      '${getProposalPath(spaceId, proposalId)}/vote';
}
