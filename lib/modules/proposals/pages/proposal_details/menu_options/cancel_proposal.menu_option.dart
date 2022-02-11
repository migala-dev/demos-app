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
    final spaceId = SpaceBloc().state!.spaceId!;
    await ProposalService().cancelProposal(spaceId, proposalId);
    Navigator.pop(context);
  }
}
