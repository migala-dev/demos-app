class SpaceView {
  final String spaceId;
  final String name;
  final String? pictureKey;
  final int membersCount;

  SpaceView(
      {required this.spaceId,
      required this.name,
      this.pictureKey,
      this.membersCount = 0
    });

  factory SpaceView.fromObject(Map<String, dynamic> o) => SpaceView(
      spaceId: o['spaceId'],
      name: o['name'],
      pictureKey: o['pictureKey'],
      membersCount: o['membersCount']);
}
