class ManifestoComment {
  final String manifestoCommentId;
  final String content;
  final String manifestoCommentParentId;
  final bool deleted;
  final String createdAt;
  final String createdByMember;
  final String updatedBy;

  ManifestoComment(
      this.manifestoCommentId,
      this.content,
      this.manifestoCommentParentId,
      this.deleted,
      this.createdAt,
      this.createdByMember,
      this.updatedBy);

  factory ManifestoComment.fromObject(dynamic o) => ManifestoComment(
        o['manifestoCommentId'],
        o['content'],
        o['manifestoCommentParentId'],
        o['deleted'] == 1 ? true : false,
        o['createdAt'],
        o['createdByMember'],
        o['updatedBy'],
      );

  Map<String, dynamic> toMap() => {
        'manifestoCommentId': manifestoCommentId,
        'content': content,
        'manifestoCommentParentId': manifestoCommentParentId,
        'deleted': deleted ? 1 : 0,
        'createdAt': createdAt,
        'createdByMember': createdByMember,
        'updatedBy': updatedBy,
      };
}
