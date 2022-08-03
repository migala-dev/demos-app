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

class MemberTypeChip extends StatelessWidget {
  final Color backgroundColor;
  final Color accentColor;
  final Color fontColor;

  const MemberTypeChip({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.accentColor,
    required this.fontColor,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        text,
        style: TextStyle(
          color: fontColor,
          fontWeight: FontWeight.w400,
          fontFamily: 'Rubik',
        ),
      ),
      backgroundColor: backgroundColor,
      side: BorderSide(color: accentColor, width: 1.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
