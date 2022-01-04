import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class VotoProposalRepository extends BaseRepository {
  @override
  String get fileName => 'votoProposals';
  final String tbProposals = 'votoProposals';
  final String colUserHash = 'userHash';
  final String colOptionId = 'optionId';
  final String colCreatedAt = 'createdAt';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbProposals('
        '$colUserHash TEXT,'
        '$colOptionId TEXT,'
        '$colCreatedAt TEXT)');
  }
}
