class Participation {
  final String participationId;
  final String userId;
  final String proposalId;

  Participation(this.participationId, this.userId, this.proposalId);

  factory Participation.fromObject(dynamic o) => Participation(
        o['participation_id'],
        o['user_id'],
        o['proposal_id'],
      );

  Map<String, dynamic> toMap() => {
        'participation_id': participationId,
        'user_id': userId,
        'proposal_id': proposalId,
      };
}
