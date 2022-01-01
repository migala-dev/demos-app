class VotoProposal {
  final String userHash;
  final String optionId;
  final String createdAt;

  VotoProposal(this.userHash, this.optionId, this.createdAt);

  factory VotoProposal.fromObject(dynamic o) => VotoProposal(
        o['userHash'],
        o['optionId'],
        o['createdAt'],
      );

  Map<String, dynamic> toMap() => {
        'userHash': userHash,
        'optionId': optionId,
        'createdAt': createdAt,
      };
}
