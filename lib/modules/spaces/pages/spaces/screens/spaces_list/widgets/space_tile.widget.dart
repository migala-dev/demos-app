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

import 'package:demos_app/config/themes/main_theme.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter/material.dart';

class SpaceTile<T extends SpaceView> extends StatelessWidget {
  final String Function(T) getSubtitle;
  final VoidCallback onSpaceTab;
  final T spaceView;

  const SpaceTile(
      {Key? key,
      required this.spaceView,
      required this.onSpaceTab,
      required this.getSubtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SpacePicture(
        width: 50.0,
        pictureKey: spaceView.pictureKey,
      ),
      title: Text(spaceView.name, style: const TextStyle(fontWeight: FontWeight.w600, color: primaryColor),),
      subtitle: Text(getSubtitle(spaceView), style: const TextStyle(fontWeight: FontWeight.w500),),
      onTap: () {
        onSpaceTab();
      },
    );
  }
}
