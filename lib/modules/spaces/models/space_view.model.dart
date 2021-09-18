class SpaceView {
  final String spaceId;
  final String name;
  final String? pictureKey;
  final int membersCount;

  SpaceView(
      {required this.spaceId,
      required this.name,
      this.pictureKey,
      required this.membersCount});

  factory SpaceView.fromObject(Map<String, dynamic> o) =>
      SpaceView(spaceId: o['id'], name: o['name'], membersCount: o['members']);
}
