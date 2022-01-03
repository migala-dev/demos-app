import 'package:demos_app/core/models/manifesto/manifesto.model.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/widgets/proposal_card/created_by_info.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/widgets/proposal_card/finished_in_tile.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals_page/widgets/proposal_card/vote_counter_tile.widget.dart';

class ProposalCard extends StatelessWidget {
  final Manifesto manifesto;
  const ProposalCard({Key? key, required this.manifesto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          '#1',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 10),
                        CreatedByChip(userId: manifesto.createdBy)
                      ],
                    ),
                    Text(
                      manifesto.title,
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
                const Icon(Icons.check_box_outlined, color: Colors.grey)
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FinishedInTile(
                  manifestoId: manifesto.manifestoId,
                ),
                VoteCounter(
                  manifestoId: manifesto.manifestoId,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
