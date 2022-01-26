
import 'package:demos_app/modules/proposals/pages/proposals/enums/proposal_list_type.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/repositories/proposal_view.repository.dart';

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

  Future<bool> itHasProposalsOnType(
      ProposalListType type, String spaceId) async {
    switch (type) {
      case ProposalListType.draft:
        final proposal =
            await ProposalViewsRepository().findOneDraftsBySpaceId(spaceId);
        return proposal != null;

      case ProposalListType.inProgress:
        return false;

      case ProposalListType.recent:
        return false;

      case ProposalListType.history:
        return false;
    }
  }
}
