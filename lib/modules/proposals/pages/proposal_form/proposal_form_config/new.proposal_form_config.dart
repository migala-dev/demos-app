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

import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/interfaces/proposal_form_config.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/screens/confirm_proposal.screen.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/modules/spaces/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/navigation.service.dart';
import 'package:demos_app/utils/ui/modals/open_custom_confirmation.dialog.dart';
import 'package:flutter/material.dart';

class NewProposalFormConfig implements ProposalFormConfig {
  @override
  String formTitle = 'Nueva Propuesta';

  @override
  String primaryButtonLabel = 'Confirmar';

  @override
  String saveDraftLabel = 'Guardar Borrador';

  @override
  bool showSaveDraftButton = true;

  @override
  bool showRemoveButton = false;

  @override
  Future<bool> openOnWillPopDialog(BuildContext context) async {
    const String title = '¿Deseas guardar esta propuesta como borrador?';

    final List<DialogOption> options = [
      DialogOption(label: 'Guardar', onPressed: saveDraft, isPrimary: true),
      DialogOption(label: 'No', onPressed: () {}),
    ];

    DialogOption? optionSelected =
        await openCustomConfirmDialog(context, title, options);

    return optionSelected != dialogCancelOption;
  }

  @override
  Future<void> saveDraft() async {
    final spaceId = SpaceBloc().state.spaceId!;
    final ProposalFormView proposalFormView = ProposalFormBloc().state;

    await ProposalService().createNewProposalDraft(spaceId, proposalFormView);

    ProposalViewListBloc().add(ProposalViewListUpdated(spaceId));
  }

  @override
  Future<void> remove(BuildContext context) async {}

  @override
  Future<void> primaryAction() async {
    final BuildContext context = NavigationService.navigatorKey.currentContext!;
    final ProposalFormView proposalFormView = ProposalFormBloc().state;

    final bool? confirmed = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmProposalScreen(
            title: proposalFormView.title,
            primaryActionLabel: 'Publicar'
          ),
        ));

    if (confirmed != null && confirmed) {
      final String spaceId = SpaceBloc().state.spaceId!;

      await ProposalService()
          .createAndPublishProposal(spaceId, proposalFormView);

      ProposalViewListBloc().add(ProposalViewListLoaded(spaceId));
      SpacesBloc().add(LoadSpacesEvent());
      Navigator.pop(context);
    }
  }
}
