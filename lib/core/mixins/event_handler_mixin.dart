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

import 'package:demos_app/core/event_handlers/map_event_name_to_handler.dart';
import 'package:demos_app/core/interfaces/event.handler.interface.dart';
import 'package:demos_app/core/models/cache.model.dart';

class EventHandlerMixin implements EventHandler {
  @override
  String key = '';
  List<EventHandler> get eventHandlers => [];

  @override
  Future<void> handleEvent(Cache dataEvent) async {
    EventHandler? handler =
        _getEventHandler(dataEvent.eventName, eventHandlers);
    await handler?.handleEvent(dataEvent);
  }

  EventHandler? _getEventHandler(
      String entityName, List<EventHandler> eventHandlers) {
    return mapEventNameToHandler(entityName, eventHandlers);
  }
}
