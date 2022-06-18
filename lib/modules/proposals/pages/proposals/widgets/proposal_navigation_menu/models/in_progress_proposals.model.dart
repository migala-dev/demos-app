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

import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/repositories/proposal_view.repository.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_in_progress_card.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_list_views/proposal_view_list.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';
import 'package:flutter/material.dart';

class InProgressProposals implements ProposalViewList {
  static final InProgressProposals _inProgressProposals =
      InProgressProposals._internal();

  InProgressProposals._internal();

  factory InProgressProposals() => _inProgressProposals;

  @override
  String title = 'EN PROGRESO';

  @override
  Future<List<ProposalView>> getList(String spaceId) async {
    ProposalStatus status = ProposalStatus.open;
    return await ProposalViewsRepository()
        .findAllBySpaceIdAndStatus(spaceId, status);
  }

  @override
  Widget getWidget(BuildContext context, List<ProposalView> proposals) {
    return ProposalViewListWidget(
      proposals: proposals,
      getProposalCard: (proposal) {
        return ProposalInProgressCard(proposal: proposal);
      },
    );
  }

  @override
  Future<bool> itHasProposals(String spaceId) async {
    int proposalsCount = await ProposalViewsRepository()
        .getCountBySpaceIdAndStatus(spaceId, [ProposalStatus.open]);

    return proposalsCount > 0;
  }
}
