import 'package:demos_app/modules/spaces/pages/spaces/models/settings.menu_option.dart';
import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:demos_app/widgets/general/popup_menu_options.widget.dart';
import 'package:flutter/material.dart';

class PopupSpacesMenuOptions extends StatelessWidget {
  final List<MenuOption> menuOptions = [SettingsMenuOption()];

  PopupSpacesMenuOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuOptions(menuOptions: menuOptions);
  }
}

