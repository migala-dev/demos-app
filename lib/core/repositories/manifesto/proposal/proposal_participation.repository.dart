import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/repositories/app_repository.dart';

class ProposalParticipationRepository extends AppRepository implements Table {
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
