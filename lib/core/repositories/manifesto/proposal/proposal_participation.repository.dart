import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class ProposalParticipationRepository extends BaseRepository {
  @override
  String get fileName => 'proposalParticipations';
  final String tbProposals = 'proposalParticipations';
  final String colId = 'proposalParticipationId';
  final String colUserId = 'userId';
  final String colProposalId = 'proposalId';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbProposals('
        '$colId TEXT PRIMARY KEY, '
        '$colUserId TEXT,'
        '$colProposalId TEXT)');
  }
}
