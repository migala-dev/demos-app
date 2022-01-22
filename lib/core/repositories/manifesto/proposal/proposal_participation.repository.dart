import 'package:demos_app/core/repositories/demos_table.repository.dart';

class ProposalParticipationRepository extends DemosTable {
  final String tbProposals = 'proposalParticipations';
  final String colId = 'proposalParticipationId';
  final String colUserId = 'userId';
  final String colProposalId = 'proposalId';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tbProposals('
      '$colId TEXT PRIMARY KEY, '
      '$colUserId TEXT,'
      '$colProposalId TEXT)';
}
