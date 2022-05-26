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
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/interfaces/proposal_form_config.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/services/proposal_view.service.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/utils/ui/modals/open_custom_confirmation.dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../navigation.service.dart';
import '../../../../../utils/ui/modals/open_confirmation_dialog.dart';
import '../../proposals/bloc/proposal_view_list_event.dart';
import '../screens/confirm_proposal.screen.dart';

class InProgressProposalFormConfig implements ProposalFormConfig {
  @override
  String formTitle = 'Editar propuesta';

  @override
  String primaryButtonLabel = 'Actualizar';

  @override
  String saveDraftLabel = '';

  @override
  bool showSaveDraftButton = false;

  @override
  bool showRemoveButton = true;

  @override
  Future<bool> openOnWillPopDialog(BuildContext context) async {
    const String title = '¿Estás seguro de que quieres salir?';
    final List<DialogOption> options = [
      DialogOption(label: 'Si', onPressed: () {}, isPrimary: true),
    ];

    DialogOption? optionSelected =
        await openCustomConfirmDialog(context, title, options);

    return optionSelected != dialogCancelOption;
  }

  @override
  Future<void> saveDraft() async {}

  @override
  Future<void> remove(BuildContext context) async {
    await openConfirmationDialog(context,
        content: '¿Estás seguro de que desea cancelar esta propuesta?',
        accept: () => _removeProposal(context));
  }

  Future<void> _removeProposal(BuildContext context) async {
    final ProposalFormView proposalFormView = ProposalFormBloc().state;
    final spaceId = SpaceBloc().state.spaceId!;
    await ProposalService()
        .cancelProposal(spaceId, proposalFormView.proposalId!);

    ProposalViewListBloc().add(ProposalViewListUpdated(spaceId));

    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Future<void> primaryAction() async {
    final BuildContext context = NavigationService.navigatorKey.currentContext!;
    final ProposalFormView proposalFormView = ProposalFormBloc().state;

    final bool? confirmed = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmProposalScreen(
              title: proposalFormView.title, primaryActionLabel: 'Actualizar'),
        ));

    if (confirmed != null && confirmed) {
      final spaceId = SpaceBloc().state.spaceId!;
      final proposalId = proposalFormView.proposalId!;

      await ProposalService()
          .updateProposal(spaceId, proposalId, proposalFormView);

      final proposalUpdated =
          await ProposalViewServie().getProposalViewByProposalId(proposalId);

      ProposalViewListBloc().add(ProposalViewListUpdated(spaceId));

      ProposalDetailsBloc().add(SetProposalViewEvent(proposalUpdated!));
      Navigator.pop(context);
    }
  }
}
