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
      o['manifesto_id'],
      o['title'],
      o['content'],
      o['create_by'],
      o['option_type'],
      o['space_id']);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'manifesto_id': manifestoId,
        'title': title,
        'content': content,
        'create_by': createdBy,
        'option_type': optionType,
        'space_id': spaceId
      };
}
