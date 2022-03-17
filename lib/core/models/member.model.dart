/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/enums/space_role.enum.dart';

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
  InvitationStatus? invitationStatus;
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
    map['invitationStatus'] = invitationStatus?.index;
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
