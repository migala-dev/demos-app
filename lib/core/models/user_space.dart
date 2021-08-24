import 'package:demos_app/core/enums/invitation-status.enum.dart';

class UserSpace {
  String? _userSpaceId;
  String? _spaceId;
  String? _userId;
  InvitationStatus? _invitationStatus;
  bool _deleted = false;
  String? _createdBy;
  String? _updatedBy;
  String? _createdAt;
  String? _updatedAt;

  String? get userSpaceId => this._userSpaceId;
  String? get spaceId => this._spaceId;
  String? get userId => this._userId;
  InvitationStatus? get invitationStatus => this._invitationStatus;
  bool get deleted => this._deleted;
  String? get createdBy => this._createdBy;
  String? get updatedBy => this._updatedBy;
  String? get createdAt => this._createdAt;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["userSpaceId"] = _userSpaceId;
    map["spaceId"] = _spaceId;
    map["userId"] = _userId;
    map["invitationStatus"] = _invitationStatus;
    map["deleted"] = _deleted;
    map["createdBy"] = _createdBy;
    map["updatedBy"] = _updatedBy;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    return map;
  }

  UserSpace.fromObject(dynamic o) {
    this._userSpaceId = o["userSpaceId"];
    this._spaceId = o["spaceId"];
    this._userId = o["userId"];
    this._invitationStatus = getInvitationStatusFromInt(o["invitationStatus"]);
    this._deleted = o["deleted"];
    this._createdBy = o["createdBy"];
    this._updatedBy = o["updatedBy"];
    this._createdAt = o["createdAt"];
    this._updatedAt = o["updatedAt"];
  }
}
