import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class ProposalRepository extends BaseRepository {
  @override
  String get fileName => 'proposals';
  final String tbProposals = 'proposals';
  final String colId = 'proposal_id';
  final String colManifestoId = 'manifesto_id';
  final String colStatus = 'status';
  final String colProgressStatus = 'progress_status';
  final String colExpiratedAt = 'expirated_at';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbProposals('
        '$colId TEXT PRIMARY KEY, '
        '$colManifestoId TEXT,'
        '$colStatus INTEGER,'
        '$colProgressStatus INTEGER,'
        '$colExpiratedAt TEXT,');
  }
}
