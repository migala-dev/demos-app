import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class ProposalVote extends BaseRepository {
  @override
  String get fileName => 'proposalVotes';
  final String tbProposals = 'proposalVotes';
  final String colId = 'proposalVoteId';
  final String colProposalId = 'proposalId';
  final String colUserHash = 'userHash';
  final String colManifestoOptionId = 'manifestoOptionId';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedAt = 'updatedAt';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbProposals('
        '$colId TEXT PRIMARY KEY, '
        '$colProposalId TEXT,'
        '$colUserHash TEXT,'
        '$colManifestoOptionId TEXT,'
        '$colCreatedAt TEXT,'
        '$colUpdatedAt TEXT)');
  }
}
