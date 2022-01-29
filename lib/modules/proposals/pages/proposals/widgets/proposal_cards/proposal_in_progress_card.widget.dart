import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_card.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_cart_info.widget.dart';
import 'package:flutter/material.dart';

class ProposalInProgressCard extends StatelessWidget implements ProposalCard {
  @override
  final ProposalView proposal;
  final int totalOfMembers;

  const ProposalInProgressCard({Key? key, required this.proposal, this.totalOfMembers = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(proposal.title ?? 'Sin titulo',
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProposalCardInfo(
                    getIcon: (size, color) => Icon(
                      Icons.calendar_today,
                      size: size,
                      color: color,
                    ),
                    title: 'Termina el:',
                    content: proposal.createdAtFormated,
                  ),
                  ProposalCardInfo(
                    getIcon: (size, color) => Icon(
                      Icons.how_to_vote,
                      size: size,
                      color: color,
                    ),
                    title: 'Votos:',
                    content: '${proposal.votesCount}/$totalOfMembers',
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
