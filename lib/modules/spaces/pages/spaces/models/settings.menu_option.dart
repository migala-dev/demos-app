import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class SettingsMenuOption implements MenuOption {
  String name = 'Ajustes';
  IconData icon = Icons.settings;

  @override
  void Function(BuildContext) onTap = (BuildContext context) {
    Navigator.of(context).pushNamed(Routes.settings);
  };
}
