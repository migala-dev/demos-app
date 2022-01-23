import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/app_database.dart';

class AppRepository {
  Future<Database?> get db async => AppDatabase.db;
}
