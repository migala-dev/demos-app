import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class DeleteProposalDraftMenuOption implements MenuOption {
  @override
  String name = 'Eliminar';
  @override
  IconData icon = Icons.delete;

  @override
  void onTap(BuildContext context) async {
    final proposalId = ProposalFormBloc().state.proposalId!;
    await ProposalService().deleteProposalDraft(proposalId);
    Navigator.pop(context);
  }
}
