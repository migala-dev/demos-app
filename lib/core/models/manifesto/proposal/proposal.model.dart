import 'package:demos_app/core/enums/proposal/proposal_progress_status.enum.dart';
import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';

class Proposal {
  final String proposalId;
  final String manifestoId;
  final ProposalStatus status;
  final ProposalProgressStatus progressStatus;
  final String expiratedAt;

  Proposal(this.proposalId, this.manifestoId, this.status, this.progressStatus,
      this.expiratedAt);

  factory Proposal.fromObject(dynamic o) => Proposal(
        o['proposalId'],
        o['manifestoId'],
        getProposalStatusFromInt(o['status']),
        getProposalProgressStatusFromInt(o['progressStatus']),
        o['expiratedAt'],
      );

  Map<String, dynamic> toMap() => {
        'proposalId': proposalId,
        'manifestoId': manifestoId,
        'status': status.index,
        'progressStatus': progressStatus.index,
        'expiratedAt': expiratedAt,
      };
}
