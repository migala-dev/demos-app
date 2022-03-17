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

import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/menu_options/cancel_invitation.menuoption.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/member_profile/menu_options/delete_member.menuoption.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:demos_app/widgets/general/popup_menu_options.widget.dart';
import 'package:flutter/material.dart';
import 'package:demos_app/modules/spaces/validators/is_current_user_admin.widget_validator.dart';
import 'package:demos_app/widgets/wrappers/safe_widget/safe_widget_validator.dart';

class MemberProfilePopupMenuOptions extends StatelessWidget {
  const MemberProfilePopupMenuOptions(
      {Key? key,
      required this.memberIsInvited,
      required this.spaceId,
      required this.memberId})
      : super(key: key);

  final bool memberIsInvited;
  final String spaceId;
  final String memberId;

  @override
  Widget build(BuildContext context) {
    final MenuOption deleteOrCancelOption = memberIsInvited
        ? CancelInvitationMenuOption(spaceId, memberId)
        : DeleteMemberMenuOption(spaceId, memberId);

    return SafeWidgetValidator(
      validators: [IsCurrentUserAdminWidgetValidator()],
      child: PopupMenuOptions(menuOptions: [deleteOrCancelOption]),
    );
  }
}
