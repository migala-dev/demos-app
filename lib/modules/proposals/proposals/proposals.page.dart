import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demos_app/core/bloc/proposals_bloc/proposals_bloc.dart';
import 'package:demos_app/modules/proposals/proposals/widgets/no_proposals.widget.dart';
import 'package:demos_app/modules/proposals/proposals/widgets/proposal_navigation_menu/proposals_navigation_menu.widget.dart';
import 'package:demos_app/modules/proposals/proposals/widgets/proposals_listview.widget.dart';

class ProposalsPage extends StatelessWidget {
  const ProposalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalsBloc, ProposalsState>(
      bloc: ProposalsBloc(),
      builder: (context, state) {
        if (state is ProposalsLoadingInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        final areProposalsEmpty =
            (state as ProposalsStateWithData).proposals.isEmpty;
        if (areProposalsEmpty) {
          return Center(child: NoProposals());
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            ProposalsNavigationMenu(optionSelected: state.type),
            const SizedBox(height: 15),
            Expanded(
              child: ProposalsListView(proposals: state.proposals),
            ),
          ],
        );
      },
    );
  }
}
