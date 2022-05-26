import 'package:demos_app/core/models/manifesto/proposal/proposal_vote.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/proposal_result/option_result_info.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:flutter/material.dart';


class ProposalResult extends StatelessWidget {
  final ProposalView proposal;
  int get totalParticipation => proposal.votesTotal;

  const ProposalResult({Key? key, required this.proposal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProposalVote> nullComments =
        proposal.votes.where((o) => o.nullVoteComment != null).toList();
    bool showNullVotes = nullComments.isNotEmpty;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
                child:
                    Text('RESULTADOS', style: TextStyle(color: Colors.grey))),
            proposal.insufficientVotes
                ? Expanded(
                    child: Text(
                    'Votos Insuficientes'.toUpperCase(),
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.red),
                  ))
                : Container(),
          ],
        ),
          Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: proposal.optionsAndVotes
          .map((o) => OptionResultWidget(
                optionName: o.label,
                votesCount: o.count,
                votesTotal: proposal.votesTotal,
                isWinningOption: o.mostVoted && !proposal.insufficientVotes,
              ))
          .toList(),
    ),
        Container(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
          child: Text(
            'Votos recibidos: ${proposal.votes.length.toString()}, esperados: ${totalParticipation.toString()}, requeridos: ${proposal.requiredVotes.toString()}.',
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.right,
          ),
        ),
        showNullVotes
            ? ListTile(
                title: const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Votos Nulos',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    nullComments
                        .map((o) => '• ${o.nullVoteComment}\n')
                        .join('')
                        .toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
