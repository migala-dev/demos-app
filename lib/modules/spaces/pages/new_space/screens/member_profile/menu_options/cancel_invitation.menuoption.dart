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

import 'package:demos_app/core/api/member.api.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:demos_app/utils/ui/modals/open_confirmation_dialog.dart';
import 'package:flutter/material.dart';

class CancelInvitationMenuOption implements MenuOption {
  final String spaceId;
  final String memberId;

  @override
  String name = 'Cancelar Invitación';

  @override
  IconData icon = Icons.cancel;

  @override
  void onTap(BuildContext context) async {
    await openConfirmationDialog(context,
        content: '¿Estás seguro de cancelar esta invitación?',
        accept: () async {
      await MemberApi().cancelInvitation(spaceId, memberId);
      Navigator.pop(context);
    });
  }

  CancelInvitationMenuOption(this.spaceId, this.memberId);
}
