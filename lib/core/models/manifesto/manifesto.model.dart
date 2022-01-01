class Manifesto {
  final String manifestoId;
  final String title;
  final String content;
  final String createdBy;
  final String optionType;
  final String spaceId;

  Manifesto(this.manifestoId, this.title, this.content, this.createdBy,
      this.optionType, this.spaceId);

  factory Manifesto.fromObject(dynamic o) => Manifesto(
        o['manifestoId'],
        o['title'],
        o['content'],
        o['createdBy'],
        o['optionType'],
        o['spaceId'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'manifestoId': manifestoId,
        'title': title,
        'content': content,
        'createdBy': createdBy,
        'optionType': optionType,
        'spaceId': spaceId
      };
}
