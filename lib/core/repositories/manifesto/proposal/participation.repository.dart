import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class ParticipationRepository extends BaseRepository {
  @override
  String get fileName => 'participations';
  final String tbProposals = 'participations';
  final String colId = 'participation_id';
  final String colUserId = 'user_id';
  final String colProposalId = 'proposal_id';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbProposals('
        '$colId TEXT PRIMARY KEY, '
        '$colUserId TEXT,'
        '$colProposalId TEXT,');
  }
}
