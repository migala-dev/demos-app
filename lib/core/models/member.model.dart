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
import 'package:demos_app/utils/parsers/parse_object_to_boolean.dart';

class Member {
  final String memberId;
  final String spaceId;
  final String userId;
  final SpaceRole role;
  final String? name;
  final String expiredAt;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;
  InvitationStatus invitationStatus;
  bool deleted;

  Member(
      this.memberId,
      this.spaceId,
      this.userId,
      this.role,
      this.name,
      this.expiredAt,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.invitationStatus,
      this.deleted);

  factory Member.fromObject(dynamic o) => Member(
      o['memberId'],
      o['spaceId'],
      o['userId'],
      getSpaceRoleFromString(o['role']),
      o['name'],
      o['expiredAt'],
      o['createdAt'],
      o['createdBy'],
      o['updatedAt'],
      o['updatedBy'],
      getInvitationStatusFromInt(o['invitationStatus']),
      parseObjectToBoolean(o['deleted']));

  Map<String, dynamic> toMap() => {
        'memberId': memberId,
        'spaceId': spaceId,
        'userId': userId,
        'invitationStatus': invitationStatus.index,
        'role': getSpaceRoleString(role),
        'name': name,
        'expiredAt': expiredAt,
        'deleted': deleted ? 1 : 0,
        'createdBy': createdBy,
        'updatedBy': updatedBy,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
