class ManifestoReferences {
  final String referenceId;
  final String parentId;
  final String manifestoId;

  ManifestoReferences(this.referenceId, this.parentId, this.manifestoId);

  factory ManifestoReferences.fromObject(dynamic o) => ManifestoReferences(
        o['referenceId'],
        o['parentId'],
        o['manifestoId'],
      );

  Map<String, dynamic> toMap() => {
        'referenceId': referenceId,
        'parentId': parentId,
        'manifestoId': manifestoId
      };
}
