import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class PopupMenuOptions extends StatelessWidget {
  final List<MenuOption> menuOptions;

  PopupMenuOptions({Key? key, required this.menuOptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
      onSelected: (MenuOption option) {
        if (option.open != null) {
          option.open!(context);
        } else if (option.onTap != null) {
          option.onTap!();
        }
      },
      itemBuilder: (BuildContext context) => menuOptions
          .map((option) => PopupMenuItem<MenuOption>(
              value: option, child: _MenuChildItem(option.name, option.icon)))
          .toList(),
    );
  }
}

class _MenuChildItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const _MenuChildItem(this.title, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(this.icon),
        SizedBox(
          width: 5,
        ),
        Text(this.title)
      ],
    );
  }
}
