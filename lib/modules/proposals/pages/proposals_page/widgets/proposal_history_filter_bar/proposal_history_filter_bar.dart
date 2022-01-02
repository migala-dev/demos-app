import 'package:flutter/material.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/enums/proposal_history_filter.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/widgets/proposal_history_filter_bar/proposal_history_chip_button.widget.dart';

class ProposalHistoryFilterBar extends StatelessWidget {
  final ProposalHistoryFilter selected;
  final void Function(ProposalHistoryFilter) onFilteredChange;

  const ProposalHistoryFilterBar(
      {Key? key, required this.selected, required this.onFilteredChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(width: 15),
          ProposalHistoryChipButton(
              text: 'EN PROCESO',
              selected: selected == ProposalHistoryFilter.inProgress,
              onTap: () => onFilteredChange(ProposalHistoryFilter.inProgress)),
          const SizedBox(width: 20),
          ProposalHistoryChipButton(
              text: 'RECIENTES',
              selected: selected == ProposalHistoryFilter.recient,
              onTap: () => onFilteredChange(ProposalHistoryFilter.recient)),
          const SizedBox(width: 20),
          ProposalHistoryChipButton(
              text: 'HISTORIA',
              selected: selected == ProposalHistoryFilter.all,
              onTap: () => onFilteredChange(ProposalHistoryFilter.all))
        ],
      ),
    );
  }
}
