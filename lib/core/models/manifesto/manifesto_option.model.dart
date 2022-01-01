class ManifestoOption {
  final String optionId;
  final String title;
  final String manifestoId;
  final String createdBy;

  ManifestoOption(this.optionId, this.title, this.manifestoId, this.createdBy);

  factory ManifestoOption.fromObject(dynamic o) => ManifestoOption(
        o['optionId'],
        o['title'],
        o['manifestoId'],
        o['createdBy'],
      );

  Map<String, dynamic> toMap() => {
        'optionId': optionId,
        'title': title,
        'manifestoId': manifestoId,
        'createdBy': createdBy,
      };
}
