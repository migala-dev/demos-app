import 'package:demos_app/modules/proposals/pages/proposals_page/widgets/proposal_card.widget.dart';
import 'package:flutter/material.dart';

class ProposalsPage extends StatelessWidget {
  const ProposalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text(
            'ProposalTypeFilter(selected: enum, onFilteredProposalChange: () {}))'),
        ProposalCard()
      ],
    );
  }
}
