import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal_vote.model.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/services/proposal_vote.service.dart';
import 'package:flutter/material.dart';

class ProposalResult extends StatefulWidget {
  final ProposalView proposal;

  const ProposalResult({Key? key, required this.proposal}) : super(key: key);

  @override
  State<ProposalResult> createState() => _ProposalResultState();
}

class _ProposalResultState extends State<ProposalResult> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ProposalVoteService()
            .getVotesByProposalId(widget.proposal.proposalId),
        initialData: const <ProposalVote>[],
        builder:
            (BuildContext context, AsyncSnapshot<List<ProposalVote>> snapshot) {
          List<ProposalVote>? votes = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('RESULTADOS', style: TextStyle(color: Colors.grey)),
              widget.proposal.optionType ==
                      ManifestoOptionType.inFavorOrOpposing
                  ? getInFavorResult(votes!)
                  : Container(),
            ],
          );
        });
  }

  Widget getInFavorResult(List<ProposalVote> votes) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('A Favor: ${votes.where((v) => v.inFavor!).length}',
            style: const TextStyle(color: Colors.black)),
        Text('En contra: ${votes.where((v) => !v.inFavor!).length}',
            style: const TextStyle(color: Colors.black)),
        const Text('Resultado: Votos Insuficientes',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
