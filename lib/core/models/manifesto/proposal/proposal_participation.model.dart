class ProposalParticipation {
  final String proposalParticipationId;
  final String userId;
  final String proposalId;
  final String memberId;
  final bool participated;

  ProposalParticipation(
      this.proposalParticipationId, this.userId, this.proposalId, this.memberId, this.participated);

  factory ProposalParticipation.fromObject(dynamic o) => ProposalParticipation(
        o['proposalParticipationId'],
        o['userId'],
        o['proposalId'],
        o['memberId'],
        o['participated'].runtimeType == int ?  o['participated'] != 0 : o['participated'],
      );

  Map<String, dynamic> toMap() => {
        'proposalParticipationId': proposalParticipationId,
        'userId': userId,
        'proposalId': proposalId,
        'memberId': memberId,
        'participated': participated
      };
}
