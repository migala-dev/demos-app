class ManifestoCommentVote {
  final String manifestoCommentVoteId;
  final String userId;
  final bool upvote;
  final String createdAt;
  final String updatedAt;

  ManifestoCommentVote(
    this.manifestoCommentVoteId,
    this.userId,
    this.upvote,
    this.createdAt,
    this.updatedAt,
  );

  factory ManifestoCommentVote.fromObject(dynamic o) => ManifestoCommentVote(
        o['manifestoCommentVoteId'],
        o['userId'],
        o['upvote'] == 1 ? true : false,
        o['createdAt'],
        o['updatedAt'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'manifestoCommentVoteId': manifestoCommentVoteId,
        'userId': userId,
        'upvote': upvote ? 1 : 0,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
