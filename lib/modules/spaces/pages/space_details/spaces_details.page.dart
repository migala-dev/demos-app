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

import 'package:demos_app/modules/spaces/space.screen.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demos_app/modules/spaces/pages/space_details/widgets/space_picture_header.widget.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/config/routes/routes.dart';

class SpaceDetailsScreen extends StatelessWidget {
  const SpaceDetailsScreen({Key? key}) : super(key: key);

  void goToSpaceSettings(BuildContext context) =>
      Navigator.pushNamed(context, Routes.spaceSettings);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpaceBloc, SpaceView>(
        bloc: SpaceBloc(),
        builder: (context, space) {
          if (space.spaceId == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
                titleSpacing: 0,
                title: GestureDetector(
                  child: Row(
                    children: [
                      SpacePictureHeader(pictureKey: space.pictureKey),
                      Text(space.name)
                    ],
                  ),
                  onTap: () => goToSpaceSettings(context),
                )),
            body: const SpaceScreen(),
          );
        });
  }
}
