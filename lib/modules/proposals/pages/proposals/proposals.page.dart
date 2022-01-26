import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_state.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/no_proposals.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_list_views/proposal_draft_list_view.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/proposals_navigation_menu.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'enums/proposal_list_type.enum.dart';
import 'models/proposal_view.model.dart';

class ProposalsPage extends StatelessWidget {
  const ProposalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalViewListBloc, ProposalViewListState>(
      bloc: ProposalViewListBloc(),
      builder: (context, state) {
        if (state is ProposalViewListLoadingInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProposalViewListEmpty) {
          return Center(child: NoProposals());
        }

        state as ProposalViewListWithData;

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            ProposalsNavigationMenu(optionSelected: state.type),
            const SizedBox(height: 15),
            Expanded(
              child: getListViewByProposalListType(state.type, state.proposals),
            ),
          ],
        );
      },
    );
  }

  Widget getListViewByProposalListType(
      ProposalListType type, List<ProposalView> proposals) {
    switch (type) {
      case ProposalListType.draft:
        return ProposalDraftListView(proposals: proposals);
      case ProposalListType.inProgress:
        return Container();
      case ProposalListType.recent:
        return Container();
      case ProposalListType.history:
        return Container();
    }
  }
}
