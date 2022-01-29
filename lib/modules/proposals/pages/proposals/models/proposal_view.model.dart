import 'package:demos_app/core/enums/proposal/proposal_progress_status.enum.dart';
import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/shared/services/date_formatter.service.dart';

class ProposalView {
  final String manifestoId;
  final String proposalId;
  final String? title;
  final String spaceId;
  final String createdBy;
  final String createdAt;
  final ProposalStatus status;
  final ProposalProgressStatus progressStatus;
  final int votesCount;

  String get createdAtFormated =>
      DateFormatterService.parseToDayMonthYearDate(createdAt);

  ProposalView(
    this.manifestoId,
    this.proposalId,
    this.title,
    this.spaceId,
    this.createdBy,
    this.createdAt,
    this.status,
    this.progressStatus,
    this.votesCount,
  );

  factory ProposalView.fromObject(dynamic o) => ProposalView(
        o['manifestoId'],
        o['proposalId'],
        o['title'],
        o['spaceId'],
        o['createdBy'],
        o['createdAt'],
        ProposalStatus.values[o['status']],
        ProposalProgressStatus.values[o['progressStatus']],
        o['votesCount'],
      );
}
