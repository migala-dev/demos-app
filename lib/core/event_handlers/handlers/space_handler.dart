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

import 'package:demos_app/modules/spaces/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/core/interfaces/event.handler.interface.dart';
import 'package:demos_app/core/mixins/event_handler_mixin.dart';
import 'package:demos_app/core/models/cache.model.dart';
import 'package:demos_app/core/models/errors/user_is_not_member.error.dart';
import 'package:demos_app/core/services/general_spaces.service.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space_bloc.events.dart';

class SpaceHandler extends EventHandlerMixin {
  static final _spaceHandler = SpaceHandler._internal();
  SpaceHandler._internal();
  factory SpaceHandler() => _spaceHandler;

  @override
  String get key => 'space';
  @override
  final List<EventHandler> eventHandlers = [SpaceUpdatedEvent()];
}

class SpaceUpdatedEvent implements EventHandler {
  @override
  String key = 'updated';

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    String spaceId = dataEvent.data!['spaceId'];
    try {
      await GeneralSpaceService().updateSpace(spaceId);

      SpacesBloc().add(LoadSpacesEvent());
      SpaceBloc().add(UpdateSpaceEvent(spaceId));
    } catch (err) {
      if (err != UserIsNotMemberError()) {
        rethrow;
      }
    }
  }
}
