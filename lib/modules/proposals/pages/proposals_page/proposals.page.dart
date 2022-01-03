import 'package:flutter/material.dart';
import 'package:demos_app/core/models/manifesto/manifesto.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/widgets/proposal_history_filter_bar/proposal_history_filter_bar.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/enums/proposal_history_filter.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/widgets/proposal_card.widget.dart';

class ProposalsPage extends StatefulWidget {
  const ProposalsPage({Key? key}) : super(key: key);

  @override
  State<ProposalsPage> createState() => _ProposalsPageState();
}

class _ProposalsPageState extends State<ProposalsPage> {
  ProposalHistoryFilter filterSelected = ProposalHistoryFilter.inProgress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        ProposalHistoryFilterBar(
            selected: filterSelected,
            onFilteredChange: _onFilteredHistoricalProposalsChange),
        const SizedBox(height: 15),
        ProposalCard(
            manifesto: Manifesto('445', 'Primera Propuesta', ':0',
                '4c2965c9-e5be-4b91-b6d7-db29956334c8', 'aaa', ' aa'))
      ],
    );
  }

  void _onFilteredHistoricalProposalsChange(ProposalHistoryFilter newFilter) {
    setState(() {
      filterSelected = newFilter;
    });
  }
}
