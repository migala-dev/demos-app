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

import 'package:demos_app/core/bloc/current_user_bloc/current_user_bloc.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/modules/spaces/models/invitation_view.model.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/repositories/invitation_view.repository.dart';
import 'package:demos_app/modules/spaces/repositories/space_view.repository.dart';

class SpaceService {
  static final SpaceService _spaceService = SpaceService._internal();

  SpaceService._internal();

  factory SpaceService() {
    return _spaceService;
  }

  Future<List<SpaceView>> getSpaces() async {
    User? currentUser = CurrentUserBloc().state;

    if (currentUser != null) {
      List<SpaceView> spaces =
          await SpaceViewsRepository().findByUserId(currentUser.userId!);
      return spaces;
    }

    return [];
  }

  Future<List<InvitationView>> getInvitations() async {
    User? currentUser = CurrentUserBloc().state;

    if (currentUser != null) {
      List<InvitationView> invitations = await InvitationViewsRepository()
          .getInvitationsByUserId(currentUser.userId!);
      return invitations;
    }

    return [];
  }
}
