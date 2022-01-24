import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal.model.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:sqflite/sqflite.dart';

class ProposalRepository extends AppRepository implements Table {
  static final ProposalRepository _proposalRepository =
      ProposalRepository.internal();
  ProposalRepository.internal();
  factory ProposalRepository() => _proposalRepository;

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

  Future<String> insert(Proposal proposal) async {
    Database? db = await this.db;
    Proposal? proposalSaved = await findById(proposal.proposalId);
    if (proposalSaved == null) {
      await db!.insert(tbProposals, proposal.toMap());
      return proposal.proposalId;
    }
    return proposalSaved.proposalId;
  }

  Future<Proposal?> findById(String proposalId) async {
    Database? db = await this.db;
    final result = await db!
        .rawQuery("SELECT * FROM $tbProposals WHERE $colId = '$proposalId'");
    return result.isNotEmpty ? Proposal.fromObject(result[0]) : null;
  }
}
