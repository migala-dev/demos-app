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

import 'package:demos_app/core/api/space.api.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space_bloc.events.dart';

class SpaceDetailsService {

  Future<void> updateName(String spaceId, String name) async {
    Space space = await SpaceApi().updateSpaceName(spaceId, name);

    await SpacesRepository().updateSpace(space);

    SpaceBloc().add(UpdateSpaceEvent(spaceId));
  }

  Future<void> updateDescription(String spaceId, String description) async {
    Space space = await SpaceApi().updateSpaceDescription(spaceId, description );

    await SpacesRepository().updateSpace(space);

    SpaceBloc().add(UpdateSpaceEvent(spaceId));
  }

  Future<void> updatePercentages(String spaceId, int participationPercentage, int approvalPercentage) async {
    Space space = await SpaceApi().updateSpacePercentages(spaceId, participationPercentage, approvalPercentage);

    await SpacesRepository().updateSpace(space);

    SpaceBloc().add(UpdateSpaceEvent(spaceId));
  }

}
