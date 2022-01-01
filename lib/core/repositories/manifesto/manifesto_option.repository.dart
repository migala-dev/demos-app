import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class ManifestoOptionRepository extends BaseRepository {
  @override
  String get fileName => 'manifesto_options';
  final String tbManifestoOptions = 'manifesto_options';
  final String colId = 'option_id';
  final String colTitle = 'title';
  final String colManifestoId = 'manifesto_id';
  final String colCreatedBy = 'create_by';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbManifestoOptions('
        '$colId TEXT PRIMARY KEY, '
        '$colTitle TEXT,'
        '$colManifestoId TEXT,'
        '$colCreatedBy TEXT,');
  }
}
