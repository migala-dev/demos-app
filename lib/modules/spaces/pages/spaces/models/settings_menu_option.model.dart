import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class SettingsMenuOption implements MenuOption {
  String name = 'Configuración';
  IconData icon = Icons.settings;

  void Function(BuildContext) open = (BuildContext context) {
    Navigator.of(context).pushNamed(Routes.settings);
  };
}
