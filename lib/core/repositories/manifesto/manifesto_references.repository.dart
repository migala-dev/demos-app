import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class ManifestoReferencesRepository extends BaseRepository {
  @override
  String get fileName => 'manifesto_references';
  final String tbManifestoReferences = 'manifesto_references';
  final String colId = 'reference_id';
  final String parentId = 'parent_id';
  final String colManifestoId = 'manifesto_id';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbManifestoReferences('
        '$colId TEXT PRIMARY KEY, '
        '$parentId TEXT,'
        '$colManifestoId TEXT,');
  }
}
