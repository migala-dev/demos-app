import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal_vote.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/proposal_result/option_result_info.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/proposal_result/result_counter/result_counter.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:flutter/material.dart';

class MultipleOptionsResultCounter extends ResultCounterHelper
    implements ResultCounter {
  @override
  ManifestoOptionType optionType = ManifestoOptionType.multipleOptions;

  @override
  Widget getCounterWidget(ProposalView proposal, List<ProposalVote> votes) {
    String? winnerOptionId = getWinnerOptionId(votes);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: proposal.manifestoOptions
          .map((o) => OptionResultWidget(
                optionName: o.title,
                votesCount: votes
                    .where((v) => v.manifestoOptionId == o.manifestoOptionId)
                    .length,
                votesTotal: proposal.votesTotal,
                isWinningOption: winnerOptionId == o.manifestoOptionId,
              ))
          .toList(),
    );
  }

  @override
  int getTotalOfVotesRequired(ProposalView proposal) {
    SpaceView space = SpaceBloc().state;
    int porcentage = space.participationPercentage;
    return calculateRequiredVotes(proposal.votesTotal, porcentage);
  }

  String? getWinnerOptionId(List<ProposalVote> votes) {
    Map<String, int> votesCounter = {};
    votes.where((o) => o.manifestoOptionId != null).forEach((o) {
      votesCounter[o.manifestoOptionId!] =
          votesCounter[o.manifestoOptionId!] == null
              ? 1
              : votesCounter[o.manifestoOptionId!]! + 1;
    });

    List<MapEntry<String, int>> votesCounterList = votesCounter.entries.map<MapEntry<String, int>>((e) => e).toList();
    
    votesCounterList.sort((a, b) => a.value.compareTo(b.value));

    return votesCounterList.isNotEmpty ? votesCounterList.first.key : null;
  }
}
