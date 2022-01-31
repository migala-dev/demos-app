import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_card.interface.dart';
import 'package:flutter/material.dart';

class ProposalViewListWidget extends StatelessWidget {
  final ProposalCard Function(ProposalView) getProposalCard;
  final List<ProposalView> proposals;

  const ProposalViewListWidget({Key? key, required this.proposals, required this.getProposalCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: proposals.length,
      itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: getProposalCard(proposals[index]),
    ));
  }
}
