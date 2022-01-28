import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/modules/proposals/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/proposals/repositories/proposal_view.repository.dart';
import 'package:demos_app/modules/proposals/proposals/widgets/proposal_list_views/proposal_draft_list_view.widget.dart';
import 'package:demos_app/modules/proposals/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';
import 'package:flutter/material.dart';

class DraftProposals implements ProposalViewList {
  static final DraftProposals _draftProposals = DraftProposals._internal();

  DraftProposals._internal();

  factory DraftProposals() => _draftProposals;

  @override
  String title = 'BORRADORES';

  @override
  Widget getWidget(BuildContext context, List<ProposalView> proposals) {
    return ProposalDraftListView(
            proposals: proposals,
          );
  }

  @override
  Future<List<ProposalView>> getList(String spaceId) async {
    ProposalStatus status = ProposalStatus.draft;
    return await ProposalViewsRepository().findAllBySpaceIdAndStatus(spaceId, status);
  }

  @override
  Future<bool> itHasProposals(String spaceId) async {
    ProposalStatus status = ProposalStatus.draft;
    ProposalView? firstProposal = await ProposalViewsRepository().findOneBySpaceIdAndStatus(spaceId, status);

    return firstProposal != null;
  }
}
