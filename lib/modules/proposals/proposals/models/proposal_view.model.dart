import 'package:demos_app/core/enums/proposal/proposal_progress_status.enum.dart';
import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';

class ProposalView {
  final String manifestoId;
  final String title;
  final String spaceId;
  final String createdBy;
  final String createdAt;
  final ProposalStatus status;
  final ProposalProgressStatus progressStatus;

  ProposalView(
    this.manifestoId,
    this.title,
    this.spaceId,
    this.createdBy,
    this.createdAt,
    this.status,
    this.progressStatus,
  );

  factory ProposalView.fromObject(dynamic o) => ProposalView(
        o['manifestoId'],
        o['title'],
        o['spaceId'],
        o['createdBy'],
        o['createdAt'],
        o['status'],
        o['progressStatus'],
      );
}
