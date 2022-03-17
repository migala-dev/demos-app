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
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/enums/member_type.dart';
import 'package:demos_app/shared/services/date_formatter.service.dart';
import 'package:demos_app/shared/services/phone_formatter.service.dart';

class MemberView {
  final String defaultName = 'Sin Nombre';
  final String userId;
  final String? memberId;
  final String? spaceId;
  final String? userName;
  final String? phoneNumber;
  final String? profilePictureKey;
  final int proposalVotedCount;
  final int proposalCreatedCount;
  final InvitationStatus? invitationStatus;
  final String? memberCreatedAt;
  String? invitationExpiredAt;
  SpaceRole? role;
  String? memberName;

  String get displayName {
    if (memberName != null && memberName!.isNotEmpty) return memberName!;

    if (userName != null && userName!.isNotEmpty) return userName!;

    if (phoneNumber != null) return phoneNumberFormatted;

    return defaultName;
  }

  String get currentMemberName {
    if (memberName != null && memberName!.isNotEmpty) return memberName!;

    if (userName != null && userName!.isNotEmpty) return userName!;

    return defaultName;
  }

  String get memberCreatedAtFormatted =>
      DateFormatterService.parseToStandardDate(memberCreatedAt ?? '');

  String get phoneNumberFormatted => PhoneFormatterService.format(phoneNumber);

  String get invitationExpiredAtFormatted =>
      DateFormatterService.parseToStandardDate(invitationExpiredAt ?? '');

  MemberType get memberType {
    if (role == null) return MemberType.invited;
    if (invitationStatus == InvitationStatus.sended ||
        invitationStatus == InvitationStatus.received) {
      return MemberType.invited;
    }

    switch (role) {
      case SpaceRole.admin:
        return MemberType.administrator;
      case SpaceRole.representative:
        return MemberType.representative;
      case SpaceRole.worker:
      default:
        return MemberType.worker;
    }
  }

  bool get isInvited => memberType == MemberType.invited;

  MemberView(
      {required this.userId,
      this.proposalCreatedCount = 0,
      this.proposalVotedCount = 0,
      required this.role,
      required this.memberCreatedAt,
      this.memberName,
      this.invitationStatus,
      this.profilePictureKey,
      this.memberId,
      this.spaceId,
      this.userName,
      this.phoneNumber,
      this.invitationExpiredAt});

  factory MemberView.fromObject(dynamic o) => MemberView(
      userId: o['userId'],
      role: getSpaceRoleFromString(o['role']),
      memberCreatedAt: o['memberCreatedAt'],
      proposalCreatedCount: o['proposalCreatedCount'],
      proposalVotedCount: o['proposalVotedCount'],
      memberName: o['memberName'],
      invitationStatus: InvitationStatus.values[o['invitationStatus']],
      profilePictureKey: o['profilePictureKey'],
      memberId: o['memberId'],
      spaceId: o['spaceId'],
      userName: o['userName'],
      phoneNumber: o['phoneNumber'],
      invitationExpiredAt: o['invitationExpiredAt']);
}
