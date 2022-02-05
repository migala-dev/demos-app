import 'package:demos_app/core/models/manifesto/manifesto.model.dart';
import 'package:demos_app/core/models/manifesto/manifesto_option.model.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal.model.dart';

class ProposalResponse {
  final Manifesto? manifesto;
  final List<ManifestoOption>? manifestoOptions;
  final Proposal? proposal;

  ProposalResponse(
    this.manifesto,
    this.manifestoOptions,
    this.proposal,
  );

  factory ProposalResponse.fromObject(dynamic o) => ProposalResponse(
        o.containsKey('manifesto')
            ? Manifesto.fromObject(o['manifesto'])
            : null,
        o.containsKey('manifestoOptions')
            ? (o['manifestoOptions'] as List<dynamic>)
                .map((manifestoOption) =>
                    ManifestoOption.fromObject(manifestoOption))
                .toList()
            : null,
        o.containsKey('proposal') ? Proposal.fromObject(o['proposal']) : null,
      );
}
