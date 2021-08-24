import 'package:demos_app/core/enums/space-role.enum.dart';

class RoleUserSpace {
  String? _roleUserSpaceId;
  String? _spaceId;
  String? _userId;
  SpaceRole? _role;
  bool _deleted = false;
  String? _createdBy;
  String? _updatedBy;
  String? _createdAt;
  String? _updatedAt;

  String? get roleUserSpaceId => this._roleUserSpaceId;
  String? get spaceId => this._spaceId;
  String? get userId => this._userId;
  SpaceRole? get role => this._role;
  bool get deleted => this._deleted;
  String? get createdBy => this._createdBy;
  String? get updatedBy => this._updatedBy;
  String? get createdAt => this._createdAt;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["roleUserSpaceId"] = _roleUserSpaceId;
    map["spaceId"] = _spaceId;
    map["userId"] = _userId;
    map["role"] = _role;
    map["deleted"] = _deleted;
    map["createdBy"] = _createdBy;
    map["updatedBy"] = _updatedBy;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    return map;
  }

  RoleUserSpace.fromObject(dynamic o) {
    this._roleUserSpaceId = o["roleUserSpaceId"];
    this._spaceId = o["spaceId"];
    this._userId = o["userId"];
    this._role = getSpaceRoleFromString(o["role"]);
    this._deleted = o["deleted"];
    this._createdBy = o["createdBy"];
    this._updatedBy = o["updatedBy"];
    this._createdAt = o["createdAt"];
    this._updatedAt = o["updatedAt"];
  }
}
