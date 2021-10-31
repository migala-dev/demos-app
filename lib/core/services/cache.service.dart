import 'package:demos_app/core/api/cache.api.dart';
import 'package:demos_app/core/event_handlers/map_event_name_to_handler.dart';
import 'package:demos_app/core/event_handlers/user_space/user_space_handler.dart';
import 'package:demos_app/core/interfaces/event.handler.interface.dart';
import 'package:demos_app/core/models/cache.model.dart';
import 'package:demos_app/core/repositories/cache.repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheService {
  List<EventHandler> eventHandlers = [UserSpaceHandler()];
  bool isPendingCache = false;
  bool isRequestInProgress = false;
  final String _lastUpdatedDateKey = 'last-updated-date';
  final _storage = new FlutterSecureStorage();

  static CacheService _cacheService = new CacheService._internal();

  CacheService._internal();

  factory CacheService() {
    return _cacheService;
  }

  Future<void> getCache() async {
    if (!isRequestInProgress) {
      isRequestInProgress = true;

      await _requestCache();

      isRequestInProgress = false;
      
      _getPendingCache();
    } else {
      isPendingCache = true;
    }
  }

  Future<void> _requestCache() async {
    String? lastUpdatedDate = await _readLastUpdatedDate();
    List<Cache> dataEventList = await CacheApi().getCache(lastUpdatedDate);
    await _handleEvents(dataEventList);
    await updateLastUpdatedDate();
  }

  Future<void> _handleEvents(List<Cache> dataEventList) async {
    for (final event in dataEventList) {
      bool isNew  = await _isNewEvent(event);
      if(isNew) {
        await handleEvent(event);
        await _saveEvent(event);
      }
    }
  }

  void _getPendingCache() {
    if (isPendingCache) {
      isPendingCache = false;
      getCache();
    }
  }

  Future<void> handleEvent(Cache dataEvent) async {
    try {
      EventHandler? handler = _getEventHandler(dataEvent.entityName);
      await handler?.handleEvent(dataEvent);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateLastUpdatedDate() async {
    String nowDate = DateTime.now().toIso8601String();
    await _writeLastUpdatedDate(nowDate);
  }

  EventHandler? _getEventHandler(String entityName) {
    return mapEventNameToHandler(entityName, eventHandlers);
  }

  Future<String?> _readLastUpdatedDate() async {
    return await _storage.read(key: _lastUpdatedDateKey);
  }

  Future<void> _writeLastUpdatedDate(String lastUpdatedDate) async {
    await _storage.write(key: _lastUpdatedDateKey, value: lastUpdatedDate);
  }

  Future<bool> _isNewEvent(Cache cache) async {
    Cache? cacheSaved = await CacheRepository().findById(cache.cacheId);
    return cacheSaved == null;
  }

  Future<void> _saveEvent(Cache cache) async {
    await CacheRepository().insert(cache);
  }
}
