import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';

class Member {
  String? _memberId;
  String? _spaceId;
  String? _userId;
  SpaceRole? _role;
  String? _name;
  String? _expiredAt;
  String? _createdBy;
  String? _updatedBy;
  String? _createdAt;
  String? _updatedAt;
  late InvitationStatus invitationStatus;
  bool deleted = false;

  String? get memberId => _memberId;
  String? get spaceId => _spaceId;
  String? get userId => _userId;
  SpaceRole? get role => _role;
  String? get name => _name;
  String? get expiredAt => _expiredAt;
  String? get createdBy => _createdBy;
  String? get updatedBy => _updatedBy;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['memberId'] = _memberId;
    map['spaceId'] = _spaceId;
    map['userId'] = _userId;
    map['invitationStatus'] = invitationStatus.index;
    map['role'] = getSpaceRoleString(_role);
    map['name'] = _name;
    map['expiredAt'] = _expiredAt;
    map['deleted'] = deleted ? 1 : 0;
    map['createdBy'] = _createdBy;
    map['updatedBy'] = _updatedBy;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;

    return map;
  }

  Member.fromObject(dynamic o) {
    _memberId = o['memberId'];
    _spaceId = o['spaceId'];
    _userId = o['userId'];
    invitationStatus = getInvitationStatusFromInt(o['invitationStatus']);
    _role = getSpaceRoleFromString(o['role']);
    _name = o['name'];
    _expiredAt = o['expiredAt'];
    if (o['deleted'].runtimeType == int) {
      deleted = o['deleted'] == 0 ? false : true;
    } else {
      deleted = o['deleted'];
    }
    _createdBy = o['createdBy'];
    _updatedBy = o['updatedBy'];
    _createdAt = o['createdAt'];
    _updatedAt = o['updatedAt'];
  }
}
