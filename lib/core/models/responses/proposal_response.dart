import 'package:demos_app/core/models/manifesto/manifesto.model.dart';
import 'package:demos_app/core/models/manifesto/manifesto_option.model.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal.model.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal_participation.model.dart';

class ProposalResponse {
  final Manifesto manifesto;
  final List<ManifestoOption> manifestoOptions;
  final Proposal proposal;
  final List<ProposalParticipation> participations;

  ProposalResponse(
    this.manifesto,
    this.manifestoOptions,
    this.proposal,
    this.participations
  );

  factory ProposalResponse.fromObject(dynamic o) => ProposalResponse(
        Manifesto.fromObject(o['manifesto']),
        (o['manifestoOptions'] as List<dynamic>)
            .map((manifestoOption) =>
                ManifestoOption.fromObject(manifestoOption))
            .toList(),
        Proposal.fromObject(o['proposal']),
        o['participations'] != null ?
         (o['participations'] as List<dynamic>)
            .map((participation) =>
                ProposalParticipation.fromObject(participation))
            .toList() : [],
      );
}
