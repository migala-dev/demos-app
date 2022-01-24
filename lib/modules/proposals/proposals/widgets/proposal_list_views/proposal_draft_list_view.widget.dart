import 'package:flutter/material.dart';
import 'package:demos_app/modules/proposals/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/proposals/widgets/proposal_cards/proposal_draft_card.widget.dart';

class ProposalDraftListView extends StatelessWidget {
  final List<ProposalView> proposals;

  const ProposalDraftListView({Key? key, required this.proposals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: proposals.length,
      itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: ProposalDraftCard(
            proposal: proposals[index],
            onTap: () {},
          )),
    );
  }
}
