class VotoProposal {
  final String userHash;
  final String optionId;
  final String createdAt;

  VotoProposal(this.userHash, this.optionId, this.createdAt);

  factory VotoProposal.fromObject(dynamic o) => VotoProposal(
        o['user_hash'],
        o['option_id'],
        o['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'user_hash': userHash,
        'option_id': optionId,
        'created_at': createdAt,
      };
}
