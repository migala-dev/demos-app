class User {
  String? _userId;
  String? _name;
  late String _phoneNumber;
  String? _profilePictureKey;
  String? _createdAt;
  String? _updatedAt;

  User.withPhoneNumber(this._phoneNumber);

  String? get userId => this._userId;
  String get name => this._name ?? '';
  String get phoneNumber => this._phoneNumber;
  String? get profilePictureKey => this._profilePictureKey;

  set name(String name) => this._name = name;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["userId"] = _userId;
    map["name"] = _name;
    map["phoneNumber"] = _phoneNumber;
    map["profilePictureKey"] = _profilePictureKey;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    return map;
  }

  User.fromObject(dynamic o) {
    this._userId = o["userId"];
    this._name = o["name"];
    this._phoneNumber = o["phoneNumber"];
    this._profilePictureKey = o["profilePictureKey"];
    this._createdAt = o["createdAt"];
    this._updatedAt = o["updatedAt"];
  }

  User.fromUserObject(User user) {
    this._userId = user.userId;
    this._name = user.name;
    this._phoneNumber = user.phoneNumber;
    this._profilePictureKey = user.profilePictureKey;
  }
}
