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
        o['proposal_id'],
        o['manifesto_id'],
        getProposalStatusFromInt(o['status']),
        getProposalProgressStatusFromInt(o['progress_status']),
        o['expirated_at'],
      );

  Map<String, dynamic> toMap() => {
        'proposal_id': proposalId,
        'manifesto_id': manifestoId,
        'status': status.index,
        'progress_status': progressStatus.index,
        'expirated_at': expiratedAt,
      };
}
