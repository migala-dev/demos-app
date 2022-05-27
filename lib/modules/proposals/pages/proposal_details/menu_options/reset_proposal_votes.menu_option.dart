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

import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/confirm_proposal.screen.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/pages/proposals/services/proposal_view.service.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class ResetProposalVotesMenuOption implements MenuOption {
  @override
  String name = 'Reiniciar votación';
  @override
  IconData icon = Icons.how_to_vote;

  @override
  void onTap(BuildContext context) => confirmReset(context);

  Future<void> confirmReset(BuildContext context) async {
    final proposal = ProposalDetailsBloc().state!;

    final bool? confirmed = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmProposalScreen(
            title: proposal.title!,
            primaryActionLabel: 'Reiniciar votación',
            textActionLabel: 'reiniciar'
          ),
        ));

    if (confirmed != null && confirmed) {
      await ProposalService().resetProposalVotes(proposal.spaceId, proposal.proposalId);

      final proposalUpdated =
          await ProposalViewServie().getProposalViewByProposalId(proposal.proposalId);
          
      ProposalViewListBloc().add(ProposalViewListUpdated(proposal.spaceId));
      ProposalDetailsBloc().add(SetProposalViewEvent(proposalUpdated!));
      
    }
  }
}
