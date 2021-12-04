import 'package:demos_app/core/api/member.api.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class DeleteMemberMenuOption implements MenuOption {
  final String spaceId;
  final String memberId;

  @override
  String name = 'Eliminar miembro';
  @override
  IconData icon = Icons.delete;

  DeleteMemberMenuOption(this.spaceId, this.memberId);

  @override
  void onTap(BuildContext context) async {
    await MemberApi().deleteMember(spaceId, memberId);
    Navigator.pop(context);
  }
}

