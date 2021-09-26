import 'package:demos_app/core/api/cache.api.dart';
import 'package:demos_app/core/event_handlers/map_event_name_to_handler.dart';
import 'package:demos_app/core/event_handlers/user_space/user_space_handler.dart';
import 'package:demos_app/core/interfaces/event.handler.interface.dart';
import 'package:demos_app/core/models/data_event.model.dart';

class CacheService {
  List<EventHandler> eventHandlers = [UserSpaceHandler()];
  List<List<DataEvent>> dataEventListQueue = [];
  bool isRequestInProgress = false;
  static CacheService _cacheService = new CacheService._internal();

  CacheService._internal();

  factory CacheService() {
    return _cacheService;
  }

  Future<void> getCache() async {
    List<DataEvent> dataEventList = await CacheApi().getCache();
    await _handleEvents(dataEventList);
  }

  Future<void> _handleEvents(List<DataEvent> dataEventList) async {
    if (!isRequestInProgress) {
      isRequestInProgress = true;
      for (final event in dataEventList) {
        await handleEvent(event);
      }
      isRequestInProgress = false;
      _handleQueueEvents();
    } else {
      dataEventListQueue.add(dataEventList);
    }
  }

  void _handleQueueEvents() {
    if (dataEventListQueue.length > 0) {
      List<DataEvent> dataEventList = dataEventListQueue.first;
      dataEventListQueue.removeWhere((e) => e == dataEventList);
      _handleEvents(dataEventList);
    }
  }

  Future<void> handleEvent(DataEvent dataEvent) async {
    try {
      EventHandler? handler = _getEventHandler(dataEvent.entityName);
      await handler?.handleEvent(dataEvent);
    } catch (e) {}
  }

  EventHandler? _getEventHandler(String entityName) {
    return mapEventNameToHandler(entityName, eventHandlers);
  }
}
