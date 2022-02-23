class SpaceView {
  final String? spaceId;
  final String name;
  final String? pictureKey;
  final String? description;
  final int participationPercentage;
  final int approvalPercentage;
  final int membersCount;
  final String createdAt;

  SpaceView(
      {required this.spaceId,
      required this.name,
      this.pictureKey,
      this.membersCount = 0,
      this.description,
      this.approvalPercentage = 51,
      this.participationPercentage = 51,
      this.createdAt = ''});

  factory SpaceView.fromObject(Map<String, dynamic> o) => SpaceView(
      spaceId: o['spaceId'],
      name: o['name'],
      pictureKey: o['pictureKey'],
      membersCount: o['membersCount'],
      description: o['description'],
      participationPercentage: o['participationPercentage'],
      approvalPercentage: o['approvalPercentage'],
      createdAt: o['createdAt']);

  SpaceView.empty(
      {this.spaceId,
      this.name = '',
      this.pictureKey = '',
      this.membersCount = 0,
      this.description = '',
      this.approvalPercentage = 51,
      this.participationPercentage = 51,
      this.createdAt = ''});

}
