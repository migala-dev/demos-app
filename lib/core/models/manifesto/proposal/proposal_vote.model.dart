class ProposalVote {
  final String proposalVoteId;
  final String proposalId;
  final String userHash;
  final String manifestoOptionId;
  final String createdAt;
  final String updatedAt;
  ProposalVote(this.proposalVoteId, this.proposalId, this.userHash,
      this.manifestoOptionId, this.createdAt, this.updatedAt);

  factory ProposalVote.fromObject(dynamic o) => ProposalVote(
        o['proposalVoteId'],
        o['proposalId'],
        o['userHash'],
        o['manifestoOptionId'],
        o['createdAt'],
        o['updatedAt'],
      );

  Map<String, dynamic> toMap() => {
        'proposalVoteId': proposalVoteId,
        'proposalId': proposalId,
        'userHash': userHash,
        'manifestoOptionId': manifestoOptionId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
