

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseRepository {
  static Database? _db;
  String fileName = '';
  void createDb(Database db, int newVersion); 

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializaDb();
    }
    return _db;
  }

  Future<Database> initializaDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "$fileName.db";
    var db = await openDatabase(path, version: 1, onCreate: createDb);
    return db;
  }

}