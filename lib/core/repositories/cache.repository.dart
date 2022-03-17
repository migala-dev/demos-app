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

import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:demos_app/core/models/cache.model.dart';

class CacheRepository extends AppRepository implements Table {
  static final CacheRepository _cacheRepository = CacheRepository._internal();
  final String tblCache = 'cache';
  final String colId = 'cacheId';
  final String colEventName = 'eventName';
  final String colEntityName = 'entityName';
  final String colCreatedAt = 'createdAt';

  CacheRepository._internal();

  factory CacheRepository() {
    return _cacheRepository;
  }

  @override
  String getCreateTableQuery() {
    return 'CREATE TABLE $tblCache('
        '$colId TEXT PRIMARY KEY, '
        '$colEventName TEXT, '
        '$colEntityName TEXT, '
        '$colCreatedAt TEXT)';
  }

  Future<String> insert(Cache cache) async {
    Database? db = await this.db;
    Cache? cacheSaved = await findById(cache.cacheId);
    if (cacheSaved == null) {
      await db!.insert(tblCache, cache.toMap());
      return cache.cacheId;
    }
    return cacheSaved.cacheId;
  }

  Future<Cache?> findById(String cacheId) async {
    final Database? db = await this.db;
    final result =
        await db!.rawQuery("SELECT * FROM $tblCache WHERE $colId = '$cacheId'");
    return result.isNotEmpty ? Cache.fromObject(result[0]) : null;
  }
}
