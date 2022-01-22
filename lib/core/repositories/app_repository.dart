import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/repositories/app_database.dart';

class AppRepository implements Table {
  Future<Database?> get db async => AppDatabase.db;

  @override
  String getCreateTableQuery() => '';
}
