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
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demos_app/modules/spaces/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/empty_spaces.screen.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/loading_spaces.screen.dart';
import 'package:demos_app/modules/spaces/pages/spaces/screens/spaces_list/spaces_list.screen.dart';
import 'package:demos_app/modules/spaces/pages/spaces/utils/checkers.dart';

class SpacesScreen extends StatelessWidget {
  const SpacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpacesBloc, SpacesState>(builder: (context, state) {
      if (state is LoadingSpaces) {
        return const LoadingSpacesScreen();
      }

      if (areSpacesEmpty(state)) {
        return const EmptySpacesScreen();
      }

      return SpaceListScreen(
          spaces: state.spaces, invitations: state.invitations);
    });
  }
}
