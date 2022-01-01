class Participation {
  final String participationId;
  final String userId;
  final String proposalId;

  Participation(this.participationId, this.userId, this.proposalId);

  factory Participation.fromObject(dynamic o) => Participation(
        o['participationId'],
        o['userId'],
        o['proposalId'],
      );

  Map<String, dynamic> toMap() => {
        'participationId': participationId,
        'userId': userId,
        'proposalId': proposalId,
      };
}
