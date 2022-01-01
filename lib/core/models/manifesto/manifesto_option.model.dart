class ManifestoOption {
  final String optionId;
  final String title;
  final String manifestoId;
  final String createdBy;

  ManifestoOption(this.optionId, this.title, this.manifestoId, this.createdBy);

  factory ManifestoOption.fromObject(dynamic o) => ManifestoOption(
        o['option_id'],
        o['title'],
        o['manifesto_id'],
        o['create_by'],
      );

  Map<String, dynamic> toMap() => {
        'option_id': optionId,
        'title': title,
        'manifesto_id': manifestoId,
        'create_by': createdBy,
      };
}
