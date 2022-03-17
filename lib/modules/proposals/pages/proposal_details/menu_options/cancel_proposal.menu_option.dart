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
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:demos_app/utils/ui/modals/open_confirmation_dialog.dart';
import 'package:flutter/material.dart';

class CancelProposalMenuOption implements MenuOption {
  @override
  String name = 'Cancelar';
  @override
  IconData icon = Icons.delete;

  @override
  void onTap(BuildContext context) async {
    await openConfirmationDialog(context,
        content: '¿Estas seguro que desea cancelar esta propuesta?',
        accept: () => cancelProposal(context));
  }

  void cancelProposal(BuildContext context) async {
    final proposalId = ProposalDetailsBloc().state!.proposalId;
    final spaceId = SpaceBloc().state.spaceId!;
    await ProposalService().cancelProposal(spaceId, proposalId);
    Navigator.pop(context);
  }
}
