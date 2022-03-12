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
