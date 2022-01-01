class ManifestoReferences {
  final String referenceId;
  final String parentId;
  final String manifestoId;

  ManifestoReferences(this.referenceId, this.parentId, this.manifestoId);

  factory ManifestoReferences.fromObject(dynamic o) => ManifestoReferences(
        o['reference_id'],
        o['parent_id'],
        o['manifesto_id'],
      );

  Map<String, dynamic> toMap() => {
        'reference_id': referenceId,
        'parent_id': parentId,
        'manifesto_id': manifestoId
      };
}
