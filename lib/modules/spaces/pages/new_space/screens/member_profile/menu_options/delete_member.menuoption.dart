import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class DeleteMemberMenuOption implements MenuOption {
  String name = 'Eliminar miembro';
  IconData icon = Icons.delete;

  @override
  void Function(BuildContext context) onTap = (context) { };
}
