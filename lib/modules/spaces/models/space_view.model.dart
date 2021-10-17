class SpaceView {
  final String spaceId;
  final String name;
  final String? pictureKey;
  final int membersCount;
  final String? createdAt;

  SpaceView(
      {required this.spaceId,
      required this.name,
      this.pictureKey,
      required this.membersCount, 
      this.createdAt});

  factory SpaceView.fromObject(Map<String, dynamic> o) =>
      SpaceView(spaceId: o['id'], name: o['name'], membersCount: o['members'], createdAt: o['createdAt']);
}
