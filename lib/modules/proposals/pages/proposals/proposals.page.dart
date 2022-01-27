import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/space.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals/bloc/proposal_view_list_state.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/no_proposals.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_navigation_menu/proposals_navigation_menu.widget.dart';

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
        Space? space = SpaceBloc().state;

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            ProposalsNavigationMenu(optionSelected: state.proposalViewList),
            const SizedBox(height: 15),
            Expanded(
              child: FutureBuilder(
                  future: state.proposalViewList.getList(space!.spaceId!),
                  initialData: const <ProposalView>[],
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ProposalView>> snapshot) {
                    List<ProposalView>? proposals = snapshot.data;
                    if (proposals != null) {
                      return state.proposalViewList
                          .getWidget(context, proposals);
                    }
                    return Container();
                  }),
            ),
          ],
        );
      },
    );
  }
}