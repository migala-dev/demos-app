import 'package:demos_app/core/models/manifesto/manifesto.model.dart';
import 'package:demos_app/core/models/manifesto/manifesto_option.model.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal.model.dart';

class SendProposalDraftResponse {
  final Manifesto manifesto;
  final List<ManifestoOption> manifestoOptions;
  final Proposal proposal;

  SendProposalDraftResponse(
    this.manifesto,
    this.manifestoOptions,
    this.proposal,
  );

  factory SendProposalDraftResponse.fromObject(dynamic o) =>
      SendProposalDraftResponse(
        Manifesto.fromObject(o['manifesto']),
        (o['manifestoOptions'] as List<dynamic>)
            .map((manifestoOption) =>
                ManifestoOption.fromObject(manifestoOption))
            .toList(),
        Proposal.fromObject(o['proposal']),
      );
}
