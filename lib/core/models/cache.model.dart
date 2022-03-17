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

import 'dart:convert';

class Cache {
  String _cacheId;
  String _entityName;
  String _eventName;
  Map<String, dynamic>? _data;
  String _createdAt;

  String get cacheId => _cacheId;
  String get entityName => _entityName;
  String get eventName => _eventName;
  Map<String, dynamic>? get data => _data;
  String? get createdAt => _createdAt;

  Cache(
      {required String cacheId,
      required String entityName,
      required String eventName,
      Map<String, dynamic>? data,
      required String createdAt})
      : _cacheId = cacheId,
        _entityName = entityName,
        _eventName = eventName,
        _data = data,
        _createdAt = createdAt;

  factory Cache.fromObject(Map<String, dynamic> o) => Cache(
        cacheId: o['cacheId'],
        entityName: o['entityName'],
        eventName: o['eventName'],
        data: o['data'] != null ? jsonDecode(o['data']) : null,
        createdAt: o['createdAt'],
      );

  factory Cache.fromJson(String str) {
    final o = json.decode(str);

    return Cache.fromObject(o);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['cacheId'] = _cacheId;
    map['entityName'] = _entityName;
    map['eventName'] = _eventName;
    map['createdAt'] = _createdAt;
    return map;
  }
}
