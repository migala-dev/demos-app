import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_event.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:demos_app/utils/ui/modals/open_confirmation_dialog.dart';
import 'package:flutter/material.dart';

class DeleteProposalDraftMenuOption implements MenuOption {
  @override
  String name = 'Eliminar';
  @override
  IconData icon = Icons.delete;

  @override
  void onTap(BuildContext context) async {
    await openConfirmationDialog(context,
        content: '¿Estás seguro de que desea eliminar este borrador?',
        accept: deleteProposalDraft);

    Navigator.pop(context);
  }

  void deleteProposalDraft() async {
    final proposalId = ProposalFormBloc().state.proposalId!;
    final spaceId = SpaceBloc().state.spaceId!;
    await ProposalService().deleteProposalDraft(spaceId, proposalId);
    ProposalViewListBloc().add(ProposalViewListLoaded(spaceId));
  }
}
