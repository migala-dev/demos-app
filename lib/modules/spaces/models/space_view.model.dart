class SpaceView {
  final String spaceId;
  final String name;
  final String? pictureKey;
  final int membersCount;
  final String? invitationCreatedAt;

  SpaceView(
      {required this.spaceId,
      required this.name,
      this.pictureKey,
      this.membersCount = 0, 
      this.invitationCreatedAt});

  factory SpaceView.fromObject(Map<String, dynamic> o) =>
      SpaceView(spaceId: o['id'], name: o['name'], membersCount: o['members'], invitationCreatedAt: o['createdAt']);
}
