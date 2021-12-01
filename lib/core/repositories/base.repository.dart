import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseRepository {
  static Database? _db;
  String get fileName => '';
  void createDb(Database db, int newVersion);

  Future<Database?> get db async => _db ??= await initializaDb();

  Future<Database> initializaDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + '$fileName.db';
    final db = await openDatabase(path, version: 1, onCreate: createDb);
    return db;
  }
}
