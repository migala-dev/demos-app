import 'package:demos_app/shared/services/date_formatter.service.dart';

class User {
  String? _userId;
  String? _name;
  late String _phoneNumber;
  String? _profilePictureKey;
  String? _createdAt;
  String? _updatedAt;

  User.withPhoneNumber(this._phoneNumber);

  String? get userId => _userId;
  String get name => _name ?? '';
  String get phoneNumber => _phoneNumber;
  String? get profilePictureKey => _profilePictureKey;
  String get createdAtFormatted =>
      DateFormatterService.parseToStandardDate(_createdAt ?? '');

  set name(String name) => _name = name;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    map['userId'] = _userId;
    map['name'] = _name;
    map['phoneNumber'] = _phoneNumber;
    map['profilePictureKey'] = _profilePictureKey;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

  User.fromObject(dynamic o) {
    _userId = o['userId'];
    _name = o['name'];
    _phoneNumber = o['phoneNumber'];
    _profilePictureKey =
        o['profilePictureKey'] == 'null' ? null : o['profilePictureKey'];
    _createdAt = o['createdAt'];
    _updatedAt = o['updatedAt'];
  }

  User.fromUserObject(User user) {
    _userId = user.userId;
    _name = user.name;
    _phoneNumber = user.phoneNumber;
    _profilePictureKey = user.profilePictureKey;
  }
}
