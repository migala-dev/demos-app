import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/draft_proposals.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/in_progress_proposals.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';

List<ProposalViewList> getProposalViewLists() {
  return [
    DraftProposals(),
    InProgressProposals(),
    // ProposalListType.recent,
    // ProposalListType.history
  ];
}
