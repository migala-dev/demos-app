import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class ManifestoReferencesRepository extends BaseRepository {
  @override
  String get fileName => 'manifesto_references';
  final String tbManifestoReferences = 'manifesto_references';
  final String colId = 'referenceId';
  final String colParentId = 'parentId';
  final String colManifestoId = 'manifestoId';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbManifestoReferences('
        '$colId TEXT PRIMARY KEY, '
        '$colParentId TEXT,'
        '$colManifestoId TEXT,');
  }
}
