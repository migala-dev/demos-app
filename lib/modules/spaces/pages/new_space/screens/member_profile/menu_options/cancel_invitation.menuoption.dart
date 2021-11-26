import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class CancelInvitationMenuOption implements MenuOption {
  String name = 'Cancelar Invitación';

  IconData icon = Icons.cancel;

  @override
  VoidCallback? onTap = () {};

  @override
  void Function(BuildContext)? open;
}
