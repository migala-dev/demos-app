class Space {
  final String name;
  final int members;

  Space({required this.name, required this.members});

  factory Space.fromObject(Map<String, dynamic> o) =>
      Space(name: o['name'], members: o['members']);
}
