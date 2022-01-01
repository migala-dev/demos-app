import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class ManifestoRepository extends BaseRepository {
  @override
  String get fileName => 'manifesto';
  final String tbManifesto = 'manifesto';
  final String colId = 'manifestoId';
  final String colTitle = 'title';
  final String colContent = 'content';
  final String colCreatedBy = 'createdBy';
  final String colOptionType = 'optionType';
  final String colSpaceId = 'spaceId';

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
