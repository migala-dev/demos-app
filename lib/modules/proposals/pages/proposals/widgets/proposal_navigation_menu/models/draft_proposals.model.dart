import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/repositories/proposal_view.repository.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_draft_card.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_list_views/proposal_view_list.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';
import 'package:flutter/material.dart';

class DraftProposals implements ProposalViewList {
  static final DraftProposals _draftProposals = DraftProposals._internal();

  DraftProposals._internal();

  factory DraftProposals() => _draftProposals;

  @override
  String title = 'BORRADORES';

  @override
  Widget getWidget(BuildContext context, List<ProposalView> proposals) {
    return ProposalViewListWidget(
      proposals: proposals,
      getProposalCard: (proposal) {
        return ProposalDraftCard(proposal: proposal);
      },
    );
  }

  @override
  Future<List<ProposalView>> getList(String spaceId) async {
    ProposalStatus status = ProposalStatus.draft;
    return await ProposalViewsRepository()
        .findAllBySpaceIdAndStatus(spaceId, status);
  }

  @override
  Future<bool> itHasProposals(String spaceId) async {
    ProposalStatus status = ProposalStatus.draft;
    ProposalView? firstProposal = await ProposalViewsRepository()
        .findOneBySpaceIdAndStatus(spaceId, status);

    return firstProposal != null;
  }
}
