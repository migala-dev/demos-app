import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demos_app/core/bloc/manifestos/manifestos_bloc.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/widgets/no_proposals.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/widgets/manifestos_lisviews.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/widgets/proposal_history_filter_bar/proposal_history_filter_bar.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/enums/proposal_history_filter.dart';

class ProposalsPage extends StatefulWidget {
  const ProposalsPage({Key? key}) : super(key: key);

  @override
  State<ProposalsPage> createState() => _ProposalsPageState();
}

class _ProposalsPageState extends State<ProposalsPage> {
  ProposalHistoryFilter filterSelected = ProposalHistoryFilter.inProgress;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManifestosBloc, ManifestosState>(
      bloc: ManifestosBloc(),
      builder: (context, state) {
        if (state is ManifestosLoadSuccess) {
          if (state.manifestos.isEmpty) {
            return Center(child: NoProposals());
          }

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              ProposalHistoryFilterBar(
                  selected: filterSelected,
                  onFilteredChange: _onFilteredHistoricalProposalsChange),
              const SizedBox(height: 15),
              Expanded(
                child: ManifestosListView(manifestos: state.manifestos),
              ),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _onFilteredHistoricalProposalsChange(ProposalHistoryFilter newFilter) {
    setState(() {
      filterSelected = newFilter;
    });
  }
}
