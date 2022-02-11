import 'package:demos_app/core/models/manifesto/proposal/proposal.model.dart';

class CancelProposalResponse {
  final Proposal proposal;

  CancelProposalResponse(this.proposal);

  factory CancelProposalResponse.fromObject(dynamic o) =>
      CancelProposalResponse(Proposal.fromObject(o['proposal']));
}
