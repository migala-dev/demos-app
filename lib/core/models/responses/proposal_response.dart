import 'package:demos_app/core/models/manifesto/manifesto.model.dart';
import 'package:demos_app/core/models/manifesto/manifesto_option.model.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal.model.dart';

class ProposalResponse {
  final Manifesto manifesto;
  final List<ManifestoOption> manifestoOptions;
  final Proposal proposal;

  ProposalResponse(
    this.manifesto,
    this.manifestoOptions,
    this.proposal,
  );

  factory ProposalResponse.fromObject(dynamic o) => ProposalResponse(
        Manifesto.fromObject(o['manifesto']),
        (o['manifestoOptions'] as List<dynamic>)
            .map((manifestoOption) =>
                ManifestoOption.fromObject(manifestoOption))
            .toList(),
        Proposal.fromObject(o['proposal']),
      );
}
