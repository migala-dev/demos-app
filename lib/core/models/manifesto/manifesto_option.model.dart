class ManifestoOption {
  final String manifestoOptionId;
  final String title;
  final String manifestoId;
  final bool deleted;
  final String createdBy;
  final String createdAt;
  final String updatedBy;
  final String updatedAt;

  ManifestoOption(
    this.manifestoOptionId,
    this.title,
    this.manifestoId,
    this.deleted,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  );

  factory ManifestoOption.fromObject(dynamic o) => ManifestoOption(
        o['manifestoOptionId'],
        o['title'],
        o['manifestoId'],
        o['deleted'] == 1 ? true : false,
        o['createdBy'],
        o['createdAt'],
        o['updatedBy'],
        o['updatedAt'],
      );

  Map<String, dynamic> toMap() => {
        'manifestoOptionId': manifestoOptionId,
        'title': title,
        'manifestoId': manifestoId,
        'deleted': deleted ? 1 : 0,
        'createdBy': createdBy,
        'createdAt': createdAt,
        'updatedBy': updatedBy,
        'updatedAt': updatedAt,
      };
}
