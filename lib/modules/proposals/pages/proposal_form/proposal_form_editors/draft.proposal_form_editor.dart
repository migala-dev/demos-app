import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/interfaces/proposal_form_config.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/utils/pubish_proposal.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/widgets/popup_proposal_draft_form_menu_options.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/utils/ui/modals/open_custom_confirmation.dialog.dart';
import 'package:flutter/material.dart';

class DraftProposalFormEditor implements ProposalFormConfig {
  @override
  String formTitle = 'Editar borrador';

  @override
  String primaryButtonLabel = 'Publicar';

  @override
  List<Widget>? getEditorActions() {
    return [PopupProposalDraftFormMenuOptions()];
  }

  @override
  Future<bool> openOnWillPopDialog(BuildContext context) async {
    const String title = '¿Deseas guardar los cambios?';
    final List<DialogOption> options = [
      DialogOption(label: 'Guardar', onPressed: updateDraft, isPrimary: true),
      DialogOption(label: 'No', onPressed: () {}),
    ];

    DialogOption? optionSelected =
        await openCustomConfirmDialog(context, title, options);

    return optionSelected != dialogCancelOption;
  }

  @override
  void openPublishDialog(BuildContext context) {
    const String title = '¿Quieres publicar la propuesta?';
    final bool draftChanged = ProposalFormBloc().state.change;
    final List<DialogOption> options = [
      DialogOption(
          label: 'Publicar',
          onPressed: () {
            publishProposal();
            Navigator.pop(context);
          },
          isPrimary: true),
    ];

    if (draftChanged) {
      options.add(DialogOption(
          label: 'Actualizar Borrador',
          onPressed: () {
            updateDraft();
            Navigator.pop(context);
          }));
    }

    openCustomConfirmDialog(context, title, options);
  }

  void updateDraft() async {
    final spaceId = SpaceBloc().state.spaceId!;
    final ProposalFormView proposalFormView = ProposalFormBloc().state;

    await ProposalService().updateProposalDraft(
        spaceId, proposalFormView.proposalId!, proposalFormView);

    ProposalViewListBloc().add(ProposalViewListLoaded(spaceId));
  }
}
