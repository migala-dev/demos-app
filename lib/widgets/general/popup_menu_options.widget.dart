/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:demos_app/shared/interfaces/menu_option.interface.dart';
import 'package:flutter/material.dart';

class PopupMenuOptions extends StatelessWidget {
  final List<MenuOption> menuOptions;

  const PopupMenuOptions({Key? key, required this.menuOptions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
      onSelected: (MenuOption option) {
        option.onTap(context);
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
        Icon(icon, color: Colors.black,),
        const SizedBox(
          width: 5,
        ),
        Text(title)
      ],
    );
  }
}
