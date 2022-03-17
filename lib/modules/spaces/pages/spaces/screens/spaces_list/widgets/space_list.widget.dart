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

import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/spaces_list/widgets/space_tile.widget.dart';
import 'package:flutter/material.dart';

class SpaceListWidget<T extends SpaceView> extends StatelessWidget {
  final String Function(T) getSubtitle;
  final void Function(T) onSpaceTab;
  final List<T> spaces;
  const SpaceListWidget(
      {Key? key,
      required this.spaces,
      required this.onSpaceTab,
      required this.getSubtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: spaces.length,
      itemBuilder: (context, index) {
        T spaceView = spaces[index];
        return SpaceTile<T>(
            spaceView: spaceView,
            getSubtitle: getSubtitle,
            onSpaceTab: () {
              onSpaceTab(spaceView);
            });
      },
    );
  }
}
