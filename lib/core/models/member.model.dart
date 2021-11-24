import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';

class Member {
  String? _memberId;
  String? _spaceId;
  String? _userId;
  late InvitationStatus _invitationStatus;
  SpaceRole? _role;
  String? _name;
  String? _expiredAt;
  bool _deleted = false;
  String? _createdBy;
  String? _updatedBy;
  String? _createdAt;
  String? _updatedAt;

  String? get memberId => this._memberId;
  String? get spaceId => this._spaceId;
  String? get userId => this._userId;
  InvitationStatus get invitationStatus => this._invitationStatus;
  SpaceRole? get role => this._role;
  String? get name => this._name;
  String? get expiredAt => this._expiredAt;
  bool get deleted => this._deleted;
  String? get createdBy => this._createdBy;
  String? get updatedBy => this._updatedBy;
  String? get createdAt => this._createdAt;

  set invitationStatus(InvitationStatus status) => this._invitationStatus = status;
  set deleted(bool deleted) => this._deleted = deleted;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["memberId"] = _memberId;
    map["spaceId"] = _spaceId;
    map["userId"] = _userId;
    map["invitationStatus"] = _invitationStatus.index;
    map["role"] = getSpaceRoleString(_role);
    map["name"] = _name;
    map["expiredAt"] = _expiredAt;
    map["deleted"] = _deleted ? 1 : 0;
    map["createdBy"] = _createdBy;
    map["updatedBy"] = _updatedBy;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    return map;
  }

  Member.fromObject(dynamic o) {
    this._memberId = o["memberId"];
    this._spaceId = o["spaceId"];
    this._userId = o["userId"];
    this._invitationStatus = getInvitationStatusFromInt(o["invitationStatus"]);
    this._role = getSpaceRoleFromString(o["role"]);
    this._name = o["name"];
    this._expiredAt = o["expiredAt"];
    if (o["deleted"].runtimeType == int) {
      this._deleted = o["deleted"] == 0 ? false : true;
    } else {
      this._deleted = o["deleted"];
    }
    this._createdBy = o["createdBy"];
    this._updatedBy = o["updatedBy"];
    this._createdAt = o["createdAt"];
    this._updatedAt = o["updatedAt"];
  }
}
