import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class ManifestoOptionRepository extends BaseRepository {
  @override
  String get fileName => 'manifesto_options';
  final String tbManifestoOptions = 'manifesto_options';
  final String colId = 'manifestoOptionId';
  final String colTitle = 'title';
  final String colManifestoId = 'manifestoId';
  final String colDeleted = 'deleted';
  final String colCreatedBy = 'createdBy';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedBy = 'updatedBy';
  final String colUpdatedAt = 'updatedAt';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbManifestoOptions('
        '$colId TEXT PRIMARY KEY, '
        '$colTitle TEXT,'
        '$colManifestoId TEXT,'
        '$colDeleted INTEGER,'
        '$colCreatedBy TEXT,'
        '$colCreatedAt TEXT,'
        '$colUpdatedBy TEXT,'
        '$colUpdatedAt TEXT)');
  }
}
