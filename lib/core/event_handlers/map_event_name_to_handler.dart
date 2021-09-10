import 'package:demos_app/core/interface/event.handler.interface.dart';

EventHandler? mapEventNameToHandler(
    String keyEvent, List<EventHandler> eventHandlers) {
  for (final handler in eventHandlers) {
    if (handler.key == keyEvent) {
      return handler;
    }
  }
}
