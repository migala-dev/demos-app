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

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:demos_app/modules/spaces/models/invitation_view.model.dart';
import 'package:equatable/equatable.dart';

import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/pages/spaces/services/spaces.service.dart';

part 'spaces_event.dart';
part 'spaces_state.dart';

class SpacesBloc extends Bloc<SpacesEvent, SpacesState> {
  static final _spacesBloc = SpacesBloc._internal();
  SpacesBloc._internal() : super(LoadingSpaces()) {
    on<LoadSpacesEvent>(_onLoadSpaces);
  }
  factory SpacesBloc() => _spacesBloc;

  FutureOr<void> _onLoadSpaces(
      SpacesEvent event, Emitter<SpacesState> emit) async {
    final spaceService = SpaceService();

    final spacesStored = await spaceService.getSpaces();
    final invitationsStored = await spaceService.getInvitations();

    emit(SpacesState(spaces: spacesStored, invitations: invitationsStored));
  }
}
