class User {
  int? _userId;
  String? _name;
  late String _phoneNumber;
  String? _profilePictureKey;
  String? _createdAt;
  String? _updatedAt;

  User.withPhoneNumber(this._phoneNumber);

  int? get userId => this._userId;
  String get name => this._name ?? '';
  String get phoneNumber => this._phoneNumber;
  String get profilePictureUrl => this._profilePictureKey ?? '';

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
}
