import 'package:flutter/material.dart';
import 'package:demos_app/config/routes/routes.dart';

enum SpacesMenuOptions { settings }

class PopupSpacesMenuButton extends StatelessWidget {
  const PopupSpacesMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SpacesMenuOptions>(
      onSelected: (SpacesMenuOptions result) {
        if (result == SpacesMenuOptions.settings) {
          Navigator.of(context).pushNamed(Routes.settings);
        }
      },
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<SpacesMenuOptions>>[
        const PopupMenuItem<SpacesMenuOptions>(
            value: SpacesMenuOptions.settings,
            child: _SpacesMenuChild('Configuración', Icons.settings))
      ],
    );
  }
}

class _SpacesMenuChild extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SpacesMenuChild(this.title, this.icon, {Key? key}) : super(key: key);

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
