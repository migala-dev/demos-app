import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details_bloc.events.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/interfaces/proposal_form_config.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/services/proposal_view.service.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/utils/ui/modals/open_custom_confirmation.dialog.dart';
import 'package:flutter/material.dart';

class InProgressProposalFormConfig implements ProposalFormConfig {
  @override
  String formTitle = 'Editar propuesta';

  @override
  String primaryButtonLabel = 'Actualizar';

  @override
  List<Widget>? getEditorActions() {
    return null;
  }

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
  void openPublishDialog(BuildContext context) {
    const String title = '¿Estás seguro que deseas actualizar?';
    final List<DialogOption> options = [
      DialogOption(
          label: 'Actualizar',
          onPressed: () {
            updateProposal();
            Navigator.pop(context);
          },
          isPrimary: true)
    ];

    openCustomConfirmDialog(context, title, options);
  }

  void updateProposal() async {
    final spaceId = SpaceBloc().state.spaceId!;
    final ProposalFormView proposalFormView = ProposalFormBloc().state;
    final proposalId = proposalFormView.proposalId!;

    await ProposalService()
        .updateProposal(spaceId, proposalId, proposalFormView);

    final proposalUpdated =
        await ProposalViewServie().getProposalViewByProposalId(proposalId);

    ProposalDetailsBloc().add(SetProposalViewEvent(proposalUpdated!));
  }
}
