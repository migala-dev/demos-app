class ProposalParticipation {
  final String proposalParticipationId;
  final String userId;
  final String proposalId;
  final String memberId;

  ProposalParticipation(
      this.proposalParticipationId, this.userId, this.proposalId, this.memberId);

  factory ProposalParticipation.fromObject(dynamic o) => ProposalParticipation(
        o['proposalParticipationId'],
        o['userId'],
        o['proposalId'],
        o['memberId']
      );

  Map<String, dynamic> toMap() => {
        'proposalParticipationId': proposalParticipationId,
        'userId': userId,
        'proposalId': proposalId,
        'memberId': memberId,
      };
}
