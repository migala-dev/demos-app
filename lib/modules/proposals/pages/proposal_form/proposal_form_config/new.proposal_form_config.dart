import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/interfaces/proposal_form_config.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/utils/ui/modals/open_custom_confirmation.dialog.dart';
import 'package:flutter/material.dart';

class NewProposalFormConfig implements ProposalFormConfig {
  @override
  String formTitle = 'Nueva Propuesta';

  @override
  String primaryButtonLabel = 'Publicar';


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

    ProposalViewListBloc().add(ProposalViewListLoaded(spaceId));
  }

  @override
  Future<void> remove(BuildContext context) async {}

  @override
  Future<void> primaryAction() async {
    final String spaceId = SpaceBloc().state.spaceId!;
    final ProposalFormView proposalFormView = ProposalFormBloc().state;

    await ProposalService().createAndPublishProposal(spaceId, proposalFormView);
  }

}
