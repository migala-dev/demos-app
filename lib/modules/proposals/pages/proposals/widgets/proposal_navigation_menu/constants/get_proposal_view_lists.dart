import 'package:demos_app/core/bloc/current_user_bloc/current_user_bloc.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/core/services/general_spaces.service.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/draft_proposals.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/in_progress_proposals.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';

Future<List<ProposalViewList>> getProposalViewLists() async {
  Space? space = SpaceBloc().state;
  User? user = CurrentUserBloc().state;

  List<ProposalViewList> lists = [
    InProgressProposals(),
  ];
  if (space != null && user != null) {
    bool isRepresentative = await GeneralSpaceService()
        .isUserRepresentative(user.userId!, space.spaceId!);
    if (isRepresentative) {
      lists.insert(0, DraftProposals());
    }
  }

  return lists;
}
