

import 'package:demos_app/core/models/cache.model.dart';
import 'package:demos_app/core/repositories/base.repository.dart';
import 'package:sqflite/sqflite.dart';

class CacheRepository extends BaseRepository {
  static CacheRepository _cacheRepository = CacheRepository._internal();
  @override
  String fileName = "cache";
  String tblCache = "cache";
  String colId = "cacheId";
  String colEventName = "eventName";
  String colEntityName = "entityName";
  String colCreatedAt = "createdAt";

  CacheRepository._internal();

  factory CacheRepository() {
    return _cacheRepository;
  }

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $tblCache(" +
        "$colId TEXT PRIMARY KEY, " +
        "$colEventName TEXT, " +
        "$colEntityName TEXT, " +
        "$colCreatedAt TEXT)");
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
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblCache WHERE $colId = '$cacheId'");
    return result.length > 0 ? Cache.fromObject(result[0]) : null;
  }



}