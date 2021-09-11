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
}
