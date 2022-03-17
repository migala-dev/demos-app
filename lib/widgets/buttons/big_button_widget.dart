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

import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool disabled;
  final Color? backgroundColor;
  final Color? textColor;

  const BigButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.isLoading = false,
      this.disabled = false,
      this.backgroundColor,
      this.textColor
       })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:
            const BoxConstraints.tightFor(width: double.infinity, height: 52),
        child: isLoading ? getLoadingButton() : getMainButton(context));
  }

  Widget getLoadingButton() {
    return const ElevatedButton(
        onPressed: null,
        child: CircularProgressIndicator(
          color: Colors.black,
        ));
  }

  Widget getMainButton(BuildContext context) {
    Color color = backgroundColor ?? Theme.of(context).primaryColor;
    Color finalBackgroundColor = disabled ? Colors.grey : color;

    return ElevatedButton(
        onPressed: () {
          if (!disabled) {
            onPressed();
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(finalBackgroundColor)),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(fontSize: 16, color: textColor),
        ));
  }
}
