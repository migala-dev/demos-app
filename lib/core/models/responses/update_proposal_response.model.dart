import 'package:demos_app/core/models/manifesto/proposal/proposal.model.dart';

class UpdateProposalResponse {
  final Proposal proposal;

  UpdateProposalResponse(this.proposal);

  factory UpdateProposalResponse.fromObject(dynamic o) =>
      UpdateProposalResponse(Proposal.fromObject(o['proposal']));
}
