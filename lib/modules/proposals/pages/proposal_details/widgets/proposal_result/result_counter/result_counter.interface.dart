import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal_vote.model.dart';
import 'package:flutter/material.dart';
import '../../../../proposals/models/proposal_view.model.dart';

abstract class ResultCounter {
  abstract ManifestoOptionType optionType;
  int getTotalOfVotesRequired(ProposalView proposal);
  Widget getCounterWidget(ProposalView proposal, List<ProposalVote> votes);

}

class ResultCounterHelper {
  int calculateRequiredVotes(int votesCount, int porcentageRequired) {
    return (votesCount * porcentageRequired / 100).ceil();
  }
}
