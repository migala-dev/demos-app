import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class ManifestoRepository extends BaseRepository {
  @override
  String get fileName => 'manifesto';
  final String tbManifesto = 'manifesto';
  final String colId = 'manifesto_id';
  final String colTitle = 'title';
  final String colContent = 'content';
  final String colCreatedBy = 'create_by';
  final String colOptionType = 'option_type';
  final String colSpaceId = 'space_id';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbManifesto('
        '$colId TEXT PRIMARY KEY, '
        '$colSpaceId TEXT, '
        '$colTitle TEXT,'
        '$colContent TEXT,'
        '$colCreatedBy TEXT,'
        '$colOptionType TEXT,'
        '$colSpaceId TEXT,');
  }
}
