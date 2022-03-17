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

import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/enums/proposal_form_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class EditProposalMenuOption implements MenuOption {
  @override
  String name = 'Editar';
  @override
  IconData icon = Icons.edit;

  @override
  void onTap(BuildContext context) => goToEditProposal(context);

  void goToEditProposal(BuildContext context) {
    final proposal = ProposalDetailsBloc().state!;
    final proposalFormView = ProposalFormView(
        proposalId: proposal.proposalId,
        title: proposal.title ?? '',
        content: proposal.content ?? '',
        optionType: proposal.optionType,
        type: ProposalFormType.proposalInProgress,
        manifestoOptions: proposal.manifestoOptions);

    ProposalFormBloc().add(ProposalFormSetProposalFormView(proposalFormView));
    Navigator.pushNamed(context, Routes.proposalForm);
  }
}
