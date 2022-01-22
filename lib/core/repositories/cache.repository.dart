import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/models/cache.model.dart';
import 'package:demos_app/core/repositories/demos_table.repository.dart';

class CacheRepository extends DemosTable {
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
