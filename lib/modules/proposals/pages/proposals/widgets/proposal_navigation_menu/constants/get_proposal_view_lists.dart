import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/draft_proposals.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/in_progress_proposals.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';
import 'package:demos_app/modules/spaces/bloc/current_member/current_member.bloc.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';

Future<List<ProposalViewList>> getProposalViewLists() async {
  MemberView? currentMember = CurrentMemberBloc().state;
  List<ProposalViewList> lists = [
    InProgressProposals(),
  ];
  if (currentMember != null) {
    if (currentMember.role == SpaceRole.representative) {
      lists.insert(0, DraftProposals());
    }
  }

  return lists;
}
