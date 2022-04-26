import 'package:demos_app/core/models/manifesto/proposal/proposal_vote.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/proposal_result/result_counter/in_favor.result_counter.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/proposal_result/result_counter/multiple_options.result_counter.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/proposal_result/result_counter/result_counter.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/proposals/services/proposal_vote.service.dart';
import 'package:flutter/material.dart';

List<ResultCounter> counters = [
  InFavorResultCounter(),
  MultipleOptionsResultCounter()
];

class ProposalResult extends StatelessWidget {
  final ProposalView proposal;
  int get totalParticipation => proposal.votesTotal;
  ResultCounter get counter => counters.where((c) => c.optionType == proposal.optionType).first;

  const ProposalResult({Key? key, required this.proposal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ProposalVoteService()
            .getVotesByProposalId(proposal.proposalId),
        initialData: const <ProposalVote>[],
        builder:
            (BuildContext context, AsyncSnapshot<List<ProposalVote>> snapshot) {
          List<ProposalVote> votes = snapshot.data!;
          int requiredVotesCount = counter.getTotalOfVotesRequired(proposal);
          bool showInsufficientVotes = votes.length < requiredVotesCount;
          List<ProposalVote> nullComments = votes.where((o) => o.nullVoteComment != null).toList();
          bool showNullVotes = nullComments.isNotEmpty;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                      child: Text('RESULTADOS',
                          style: TextStyle(color: Colors.grey))),
                  showInsufficientVotes
                      ? Expanded(
                          child: Text(
                          'Votos Insuficientes'.toUpperCase(),
                          textAlign: TextAlign.right,
                          style: const TextStyle(color: Colors.red),
                        ))
                      : Container(),
                ],
              ),
              counter.getCounterWidget(proposal, votes),
              Container(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Text(
                  'Votos recibidos: ${votes.length.toString()}, esperados: ${totalParticipation.toString()}, requeridos: ${requiredVotesCount.toString()}.',
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
        });
  }
}
