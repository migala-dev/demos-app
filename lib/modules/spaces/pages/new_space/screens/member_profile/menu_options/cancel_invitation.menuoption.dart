import 'package:demos_app/core/api/member.api.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class CancelInvitationMenuOption implements MenuOption {
  final String spaceId;
  final String memberId;

  String name = 'Cancelar Invitación';

  IconData icon = Icons.cancel;

  @override
  void onTap(BuildContext context) async {
    await MemberApi().cancelInvitation(spaceId, memberId);
  }

  CancelInvitationMenuOption(this.spaceId, this.memberId);
}
