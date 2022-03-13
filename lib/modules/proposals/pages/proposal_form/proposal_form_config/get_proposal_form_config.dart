import 'package:demos_app/modules/proposals/pages/proposal_form/enums/proposal_form_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/interfaces/proposal_form_config.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/proposal_form_config/draft.proposal_form_config.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/proposal_form_config/in_progress.proposal_form_config.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/proposal_form_config/new.proposal_form_config.dart';

ProposalFormConfig getProposalFormConfigFromType(ProposalFormType type) {
  switch (type) {
    case ProposalFormType.newProposal:
      return NewProposalFormConfig();
    case ProposalFormType.draft:
      return DraftProposalFormConfig();
    case ProposalFormType.proposalInProgress:
      return InProgressProposalFormConfig();
  }
}
