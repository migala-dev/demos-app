import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class DeleteMemberMenuOption implements MenuOption {
  @override
  String name = 'Eliminar miembro';
  @override
  IconData icon = Icons.delete;

  @override
  void onTap(BuildContext context) {}
}
