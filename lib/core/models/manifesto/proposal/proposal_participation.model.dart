class ProposalParticipation {
  final String proposalParticipationId;
  final String userId;
  final String proposalId;

  ProposalParticipation(
      this.proposalParticipationId, this.userId, this.proposalId);

  factory ProposalParticipation.fromObject(dynamic o) => ProposalParticipation(
        o['proposalParticipationId'],
        o['userId'],
        o['proposalId'],
      );

  Map<String, dynamic> toMap() => {
        'proposalParticipationId': proposalParticipationId,
        'userId': userId,
        'proposalId': proposalId,
      };
}
