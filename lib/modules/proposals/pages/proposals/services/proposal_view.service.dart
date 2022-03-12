import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/repositories/proposal_view.repository.dart';

class ProposalViewServie {
  Future<ProposalView?> getProposalViewByProposalId(String proposalId) async {
    return await ProposalViewsRepository().findByProposalId(proposalId);
  }
}
