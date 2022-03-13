import 'package:demos_app/core/models/manifesto/proposal/proposal_participation.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/bloc/proposal_details.bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/spaces/bloc/current_member/current_member.bloc.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/widget_validator.interface.dart';

import '../../../services/proposal_participation.service.dart';

class CanVoteWidgetValidator implements WidgetValidator {
  @override
  Future<bool> canActivate() async {
    MemberView member = CurrentMemberBloc().state!;
    ProposalView proposal = ProposalDetailsBloc().state!;
    
    ProposalParticipation? participation = await ProposalParticipationService().findProposalParticipationByMemberId(member.memberId!, proposal.proposalId);

    return participation != null;
  }
}
