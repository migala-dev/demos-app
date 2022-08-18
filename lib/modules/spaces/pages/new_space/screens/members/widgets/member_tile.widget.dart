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

import 'package:demos_app/config/themes/main_theme.dart';
import 'package:flutter/material.dart';

import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/enums/member_type.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';

class MemberTile extends StatelessWidget {
  final MemberView member;

  const MemberTile({
    Key? key,
    required this.member,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfilePicture(
        width: 55,
        percentage: 0.9,
        imageKey: member.profilePictureKey,
      ),
      title: Row(
        children: [
          Text(member.displayName, style: const TextStyle(fontSize: 16.0)),
          const SizedBox(width: 4),
          _getRoleTile(),
        ],
      ),
      subtitle: Text(_getSubtitleText(), style: const TextStyle(fontSize: 14.0),),
    );
  }

  Widget _getRoleTile() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 22,
      decoration: const BoxDecoration(
        color: Color(0xFFF8D6A1),
        borderRadius:  BorderRadius.all(Radius.circular(4)),
      ),
      child: Text(
        getMemberTypeName(member.memberType),
        style: const TextStyle(fontSize: 11, color: primaryColor, fontWeight: FontWeight.w600),
      ),
    );
  }

  String _getSubtitleText() {
    if (member.memberType == MemberType.invited) {
      if (member.invitationStatus == InvitationStatus.received) {
        return 'Invitación recibida';
      }

      return 'Invitación enviada';
    }

    String memberAt = member.memberCreatedAtFormatted;

    return 'Desde el $memberAt';
  }
}
