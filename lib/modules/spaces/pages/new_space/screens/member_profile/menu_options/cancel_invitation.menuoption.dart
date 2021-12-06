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
