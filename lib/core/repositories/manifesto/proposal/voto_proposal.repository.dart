import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class VotoProposalRepository extends BaseRepository {
  @override
  String get fileName => 'voto';
  final String tbProposals = 'voto_proposals';
  final String colUserHash = 'user_hash';
  final String colOptionId = 'option_id';
  final String colCreatedAt = 'created_at';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbProposals('
        '$colUserHash TEXT,'
        '$colOptionId TEXT,'
        '$colCreatedAt TEXT,');
  }
}
