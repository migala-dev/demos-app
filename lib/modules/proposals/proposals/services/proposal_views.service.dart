import 'package:demos_app/modules/proposals/proposals/enums/proposal_list_type.enum.dart';
import 'package:demos_app/modules/proposals/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/proposals/repositories/proposal_view.repository.dart';

class ProposalViewsService {
  Future<List<ProposalView>> getProposalViewsByProposalListTypeAndSpaceId(
      ProposalListType type, String spaceId) async {
    switch (type) {
      case ProposalListType.draft:
        return ProposalViewsRepository().findDraftsBySpaceId(spaceId);

      case ProposalListType.inProgress:
        return [];

      case ProposalListType.recent:
        return [];

      case ProposalListType.history:
        return [];
    }
  }
}
