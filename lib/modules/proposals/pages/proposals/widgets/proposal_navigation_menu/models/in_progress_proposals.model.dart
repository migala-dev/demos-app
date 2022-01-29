import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/repositories/proposal_view.repository.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_in_progress_card.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_list_views/proposal_view_list.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/models/proposal_list.interface.dart';
import 'package:flutter/material.dart';

class InProgressProposals implements ProposalViewList {
  static final InProgressProposals _draftProposals =
      InProgressProposals._internal();

  InProgressProposals._internal();

  factory InProgressProposals() => _draftProposals;

  @override
  String title = 'EN PROGRESO';

  @override
  Future<List<ProposalView>> getList(String spaceId) async {
    ProposalStatus status = ProposalStatus.open;
    return await ProposalViewsRepository()
        .findAllBySpaceIdAndStatus(spaceId, status);
  }

  @override
  Widget getWidget(BuildContext context, List<ProposalView> proposals) {
    return ProposalViewListWidget(
      proposals: proposals,
      getProposalCard: (proposal) {
        return ProposalInProgressCard(proposal: proposal);
      },
    );
  }

  @override
  Future<bool> itHasProposals(String spaceId) async {
    ProposalStatus status = ProposalStatus.open;
    ProposalView? firstProposal = await ProposalViewsRepository()
        .findOneBySpaceIdAndStatus(spaceId, status);

    return firstProposal != null;
  }
}
