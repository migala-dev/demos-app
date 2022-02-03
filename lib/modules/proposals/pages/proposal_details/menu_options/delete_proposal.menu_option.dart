import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class DeleteProposalMenuOption implements MenuOption {
  @override
  String name = 'Eliminar';
  @override
  IconData icon = Icons.delete;

  @override
  void onTap(BuildContext context) async {
    final proposalId = ProposalDetailsBloc().state!.proposalId;
    await ProposalService().deleteProposal(proposalId);
    Navigator.pop(context);
  }
}
