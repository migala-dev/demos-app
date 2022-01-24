import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/repositories/app_repository.dart';

class ProposalRepository extends AppRepository implements Table {
  final String tbProposals = 'proposals';
  final String colId = 'proposalId';
  final String colManifestoId = 'manifestoId';
  final String colStatus = 'status';
  final String colProgressStatus = 'progressStatus';
  final String colExpiratedAt = 'expiratedAt';
  final String colCreatedBy = 'createdBy';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedBy = 'updatedBy';
  final String colUpdatedAt = 'updatedAt';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tbProposals('
      '$colId TEXT PRIMARY KEY, '
      '$colManifestoId TEXT,'
      '$colStatus INTEGER,'
      '$colProgressStatus INTEGER,'
      '$colExpiratedAt TEXT,'
      '$colCreatedBy TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedBy TEXT,'
      '$colUpdatedAt TEXT)';
}
