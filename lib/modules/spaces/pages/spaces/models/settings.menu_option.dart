import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class SettingsMenuOption implements MenuOption {
  @override
  String name = 'Ajustes';
  @override
  IconData icon = Icons.settings;

  @override
  void onTap(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.settings);
  }
}