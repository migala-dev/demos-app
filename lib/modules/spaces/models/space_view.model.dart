class SpaceView {
  final String spaceId;
  final String name;
  final String? pictureKey;
  final int membersCount;
  final String? invitationCreatedAt;
  final String? invitationExpiredAt;
  late String? invitedBy;

  SpaceView(
      {required this.spaceId,
      required this.name,
      this.pictureKey,
      this.membersCount = 0,
      this.invitationCreatedAt,
      this.invitationExpiredAt,
      this.invitedBy});

  factory SpaceView.fromObject(Map<String, dynamic> o) => SpaceView(
      spaceId: o['id'],
      name: o['name'],
      membersCount: o['members'],
      invitationCreatedAt: o['createdAt'],
      invitationExpiredAt: o['expiredAt'],
      invitedBy: o['invitedBy']);
}
