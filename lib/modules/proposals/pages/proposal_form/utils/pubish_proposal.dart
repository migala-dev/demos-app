import 'package:demos_app/modules/proposals/pages/proposal_form/bloc/proposal_form.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';
import 'package:demos_app/modules/proposals/services/proposal.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';

void publishProposal() async {
  final String spaceId = SpaceBloc().state.spaceId!;
  final ProposalFormView proposalFormView = ProposalFormBloc().state;

  await ProposalService().createAndPublishProposal(spaceId, proposalFormView);
}
