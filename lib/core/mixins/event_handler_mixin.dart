import 'package:demos_app/core/event_handlers/map_event_name_to_handler.dart';
import 'package:demos_app/core/interface/event.handler.interface.dart';
import 'package:demos_app/core/models/data_event.model.dart';

class EventHandlerMixin implements EventHandler {
  @override
  String key = '';
  List<EventHandler> eventHandlers = [];

  @override
  Future<void> handleEvent(DataEvent dataEvent) async {
    EventHandler? handler =
        _getEventHandler(dataEvent.eventName, eventHandlers);
    await handler?.handleEvent(dataEvent);
  }

  EventHandler? _getEventHandler(
      String entityName, List<EventHandler> eventHandlers) {
    return mapEventNameToHandler(entityName, eventHandlers);
  }
}
