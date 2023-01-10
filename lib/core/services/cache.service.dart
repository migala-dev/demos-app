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

import 'package:demos_app/core/api/cache.api.dart';
import 'package:demos_app/core/event_handlers/handlers/comment_handler.dart';
import 'package:demos_app/core/event_handlers/handlers/comment_vote_handler.dart';
import 'package:demos_app/core/event_handlers/handlers/proposals_handler.dart';
import 'package:demos_app/core/event_handlers/handlers/space_handler.dart';
import 'package:demos_app/core/event_handlers/handlers/member_handler.dart';
import 'package:demos_app/core/event_handlers/map_event_name_to_handler.dart';
import 'package:demos_app/core/interfaces/event.handler.interface.dart';
import 'package:demos_app/core/models/cache.model.dart';
import 'package:demos_app/core/repositories/cache.repository.dart';
import 'package:demos_app/utils/ui/toast.util.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheService {
  List<EventHandler> eventHandlers = [
    MemberHandler(),
    SpaceHandler(),
    ProposalHandler(),
    CommentHandler(),
    CommentVoteHandler()
  ];
  bool isPendingCache = false;
  bool isRequestInProgress = false;
  final String _lastUpdatedDateKey = 'last-updated-date';
  final _storage = const FlutterSecureStorage();

  static final CacheService _cacheService = CacheService._internal();

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
      bool isNew = await _isNewEvent(event);
      if (isNew) {
        await handleEvent(event);
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
      if (handler != null) {
        await handler.handleEvent(dataEvent);
        await _saveEvent(dataEvent);
      } else {
        ToastUtil.showError('Entidad no implementada: ${dataEvent.entityName}');
      }
      // ignore: empty_catches
    } catch (e) {
      
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
