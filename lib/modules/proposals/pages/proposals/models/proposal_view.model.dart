/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/core/enums/proposal/proposal_progress_status.enum.dart';
import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal_vote.model.dart';
import 'package:demos_app/modules/proposals/models/votes_count.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/forms/option_step/models/manifesto_option_view.model.dart';
import 'package:demos_app/shared/services/date_formatter.service.dart';

class ProposalView {
  final String manifestoId;
  final String proposalId;
  final String? title;
  final String? content;
  final ManifestoOptionType optionType;
  final String spaceId;
  final String createdBy;
  final String createdAt;
  final DateTime? expiredAt;
  final ProposalStatus status;
  final ProposalProgressStatus progressStatus;
  final int votesCount;
  final int votesTotal;
  final String createdByName;
  final String createdByProfilePictureKey;
  final List<ManifestoOptionView> manifestoOptions;
  final int numberOfComments;
  final int participationPercentage;
  final int approvalPercentage;
  final List<ProposalVote> votes;
  VotesCountService get _voteCountService => VotesCountService(this);
  bool get insufficientVotes => votes.length < requiredVotes;
  int get porcentageRequired =>
      optionType == ManifestoOptionType.inFavorOrOpposing
          ? approvalPercentage
          : participationPercentage;
  int get requiredVotes => (votesTotal * porcentageRequired / 100).ceil();
  String get createdAtFormated =>
      DateFormatterService.parseToDayMonthYearDate(createdAt);

  ProposalView(
      this.manifestoId,
      this.proposalId,
      this.title,
      this.content,
      this.optionType,
      this.spaceId,
      this.createdBy,
      this.createdAt,
      this.expiredAt,
      this.status,
      this.progressStatus,
      this.votesCount,
      this.votesTotal,
      this.createdByName,
      this.createdByProfilePictureKey,
      this.manifestoOptions,
      this.numberOfComments,
      this.participationPercentage,
      this.approvalPercentage,
      this.votes);

  factory ProposalView.fromObject(dynamic o) => ProposalView(
      o['manifestoId'],
      o['proposalId'],
      o['title'],
      o['content'],
      ManifestoOptionType.values[o['optionType']],
      o['spaceId'],
      o['createdBy'],
      o['createdAt'],
      o['expiredAt'] != null ? DateTime.parse(o['expiredAt']) : null,
      ProposalStatus.values[o['status']],
      ProposalProgressStatus.values[o['progressStatus']],
      o['votesCount'],
      o['votesTotal'],
      o['createdByName'],
      o['createdByProfilePictureKey'],
      o['manifestoOptions']
          .map<ManifestoOptionView>(
              (option) => ManifestoOptionView.fromObject(option))
          .toList(),
      o['numberOfComments'],
      o['participationPercentage'],
      o['approvalPercentage'],
      o['votes'] != null
          ? o['votes']
              .map<ProposalVote>((vote) => ProposalVote.fromObject(vote))
              .toList()
          : []);

  List<OptionInfo>? _optionsAndVotes;
  List<OptionInfo> get optionsAndVotes {
    _optionsAndVotes =
        _optionsAndVotes ?? _voteCountService.getOptionInfoList();
    return _optionsAndVotes!;
  }

  OptionInfo? get mostVotedOptionInfo {
    if (optionsAndVotes.where((o) => o.mostVoted).isNotEmpty) {
      OptionInfo? mostVoted = optionsAndVotes.where((o) => o.mostVoted).first;
      return mostVoted;
    }
    return null;
  }
}

class VotesCountService {
  final ProposalView _proposal;
  final List<OptionMapper> optionMappers = [
    InFavorOptionMapper(),
    MultipleOptionsOptionMapper()
  ];
  OptionMapper get _optionMapper =>
      optionMappers.where((o) => o.optionType == _proposal.optionType).first;

  VotesCountService(this._proposal);

  List<OptionInfo> getOptionInfoList() {
    return _optionMapper.mapVotesToOptionInfoList(_proposal.votes, _proposal.manifestoOptions);
  }
}

abstract class OptionMapper {
  abstract final ManifestoOptionType optionType;
  List<OptionInfo> mapVotesToOptionInfoList(List<ProposalVote> votes, List<ManifestoOptionView> manifestoOptions);
}

class InFavorOptionMapper implements OptionMapper {
  @override
  final ManifestoOptionType optionType = ManifestoOptionType.inFavorOrOpposing;

  @override
  List<OptionInfo> mapVotesToOptionInfoList(List<ProposalVote> votes, List<ManifestoOptionView> _manifestoOptions) {
    final int inFavorVotesCount = votes.where((v) => v.inFavor!).length;
    final int opposingVotesCount = votes.where((v) => !v.inFavor!).length;
    return [
      OptionInfo(
          label: 'A favor',
          count: inFavorVotesCount,
          mostVoted: opposingVotesCount < inFavorVotesCount),
      OptionInfo(
          label: 'En contra',
          count: opposingVotesCount,
          mostVoted: opposingVotesCount > inFavorVotesCount)
    ];
  }
}

class MultipleOptionsOptionMapper implements OptionMapper {
  @override
  final ManifestoOptionType optionType = ManifestoOptionType.multipleOptions;

  @override
  List<OptionInfo> mapVotesToOptionInfoList(List<ProposalVote> votes, List<ManifestoOptionView> manifestoOptions) {
    final String? winnerOptionId = _getWinnerOptionId(votes);

    return manifestoOptions
          .map((o) => OptionInfo(
                label: o.title,
                count: votes
                    .where((v) => v.manifestoOptionId == o.manifestoOptionId)
                    .length,
                mostVoted: winnerOptionId == o.manifestoOptionId,
              ))
          .toList();
  }

    String? _getWinnerOptionId(List<ProposalVote> votes) {
    final Map<String, int> votesCounter = {};
    votes.where((o) => o.manifestoOptionId != null).forEach((o) {
      votesCounter[o.manifestoOptionId!] =
          votesCounter[o.manifestoOptionId!] == null
              ? 1
              : votesCounter[o.manifestoOptionId!]! + 1;
    });

    final List<MapEntry<String, int>> votesCounterList = votesCounter.entries.map<MapEntry<String, int>>((e) => e).toList();
    
    votesCounterList.sort((a, b) => a.value.compareTo(b.value));

    return votesCounterList.isNotEmpty ? votesCounterList.first.key : null;
  }
}
