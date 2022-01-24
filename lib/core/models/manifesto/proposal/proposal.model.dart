import 'package:demos_app/core/enums/proposal/proposal_progress_status.enum.dart';
import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';

class Proposal {
  final String proposalId;
  final String manifestoId;
  final ProposalStatus status;
  final ProposalProgressStatus progressStatus;
  final String? expiratedAt;
  final String createdBy;
  final String createdAt;
  final String updatedBy;
  final String updatedAt;

  Proposal(
      this.proposalId,
      this.manifestoId,
      this.status,
      this.progressStatus,
      this.expiratedAt,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt);

  factory Proposal.fromObject(dynamic o) => Proposal(
        o['proposalId'],
        o['manifestoId'],
        ProposalStatus.values[o['status']],
        ProposalProgressStatus.values[o['progressStatus']],
        o['expiratedAt'],
        o['createdBy'],
        o['createdAt'],
        o['updatedBy'],
        o['updatedAt'],
      );

  Map<String, dynamic> toMap() => {
        'proposalId': proposalId,
        'manifestoId': manifestoId,
        'status': status.index,
        'progressStatus': progressStatus.index,
        'expiratedAt': expiratedAt,
        'createdBy': createdBy,
        'createdAt': createdAt,
        'updatedBy': updatedBy,
        'updatedAt': updatedAt,
      };
}
