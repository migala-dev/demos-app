import 'package:demos_app/core/enums/proposal/proposal_option_type.enum.dart';

class Manifesto {
  final String manifestoId;
  final String? title;
  final String? content;
  final ProposalOptionType optionType;
  final String spaceId;
  final String createdBy;
  final String createdAt;
  final String updatedBy;
  final String updatedAt;

  Manifesto(
      this.manifestoId,
      this.title,
      this.content,
      this.optionType,
      this.spaceId,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt);

  factory Manifesto.fromObject(dynamic o) => Manifesto(
        o['manifestoId'],
        o['title'],
        o['content'],
        ProposalOptionType.values[o['optionType']],
        o['spaceId'],
        o['createdBy'],
        o['createdAt'],
        o['updatedBy'],
        o['updatedAt'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'manifestoId': manifestoId,
        'title': title,
        'content': content,
        'optionType': optionType.index,
        'spaceId': spaceId,
        'createdBy': createdBy,
        'createdAt': createdAt,
        'updatedBy': updatedBy,
        'updatedAt': updatedAt,
      };
}
