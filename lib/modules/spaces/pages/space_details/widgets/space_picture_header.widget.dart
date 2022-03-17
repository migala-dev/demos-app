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

import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter/material.dart';

class SpacePictureHeader extends StatelessWidget {
  const SpacePictureHeader({Key? key, required this.pictureKey})
      : super(key: key);
  final String? pictureKey;

  @override
  Widget build(BuildContext context) {
    if (pictureKey != null) {
      return Container(
        child: SpacePicture(
          width: 32,
          pictureKey: pictureKey,
        ),
        margin: const EdgeInsets.only(right: 12.0),
      );
    } else {
      return Container();
    }
  }
}
