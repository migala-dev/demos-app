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
      this.numberOfComments);

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
      o['numberOfComments']);
}
