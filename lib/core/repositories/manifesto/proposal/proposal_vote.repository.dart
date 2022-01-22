import 'package:demos_app/core/repositories/app_repository.dart';

class ProposalVoteRepository extends AppRepository {
  final String tbProposals = 'proposalVotes';
  final String colId = 'proposalVoteId';
  final String colProposalId = 'proposalId';
  final String colUserHash = 'userHash';
  final String colManifestoOptionId = 'manifestoOptionId';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedAt = 'updatedAt';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tbProposals('
      '$colId TEXT PRIMARY KEY, '
      '$colProposalId TEXT,'
      '$colUserHash TEXT,'
      '$colManifestoOptionId TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedAt TEXT)';
}
