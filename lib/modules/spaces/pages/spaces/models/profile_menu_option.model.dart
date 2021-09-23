import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class ProfileMenuOption implements MenuOption {
  String name = 'Perfil';
  IconData icon = Icons.person;

  void Function(BuildContext) open = (BuildContext context) {
    Navigator.of(context).pushNamed(Routes.settingsProfile);
  };
}
