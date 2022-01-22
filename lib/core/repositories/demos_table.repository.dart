import 'package:demos_app/core/repositories/demos.repository.dart';
import 'package:sqflite/sqflite.dart';

abstract class DemosTable {
  Future<Database?> get db async => DemosRepository.db;

  String getCreateTableQuery() => '';
}
