import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal_vote.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/proposal_result/option_result_info.widget.dart';
import 'package:demos_app/modules/proposals/pages/proposal_details/widgets/proposal_result/result_counter/result_counter.interface.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:flutter/material.dart';

class InFavorResultCounter extends ResultCounterHelper
    implements ResultCounter {
  @override
  ManifestoOptionType optionType = ManifestoOptionType.inFavorOrOpposing;

  @override
  Widget getCounterWidget(ProposalView proposal, List<ProposalVote> votes) {
    final bool areSuffientVotes = votes.length >= getTotalOfVotesRequired(proposal);
    final int inFavorVotesCount = votes.where((v) => v.inFavor!).length;
    final int opposingVotesCount = votes.where((v) => !v.inFavor!).length;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OptionResultWidget(
          optionName: 'A Favor',
          votesCount: inFavorVotesCount,
          votesTotal: proposal.votesTotal,
          isWinningOption: areSuffientVotes && opposingVotesCount < inFavorVotesCount,
        ),
        OptionResultWidget(
          optionName: 'En contra',
          votesCount: opposingVotesCount,
          votesTotal: proposal.votesTotal,
          isWinningOption: areSuffientVotes && opposingVotesCount > inFavorVotesCount,
        ),
      ],
    );
  }

  @override
  int getTotalOfVotesRequired(ProposalView proposal) {
    return calculateRequiredVotes(proposal.votesTotal, proposal.approvalPercentage);
  }
}
