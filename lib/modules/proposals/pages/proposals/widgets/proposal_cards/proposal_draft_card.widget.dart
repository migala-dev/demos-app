import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/widgets/proposal_cards/proposal_card.interface.dart';
import 'package:flutter/material.dart';

class ProposalDraftCard extends StatelessWidget implements ProposalCard {
  @override
  final ProposalView proposal;

  const ProposalDraftCard(
      {Key? key, required this.proposal })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CREADO EL:',
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey.shade600),
                      ),
                      Text(
                        proposal.createdAtFormated,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
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
