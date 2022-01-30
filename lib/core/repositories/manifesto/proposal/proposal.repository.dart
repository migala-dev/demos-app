import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal.model.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:sqflite/sqflite.dart';

class ProposalRepository extends AppRepository implements Table {
  static final ProposalRepository _proposalRepository =
      ProposalRepository.internal();
  ProposalRepository.internal();
  factory ProposalRepository() => _proposalRepository;

  final String tblProposals = 'proposals';
  final String colId = 'proposalId';
  final String colManifestoId = 'manifestoId';
  final String colStatus = 'status';
  final String colProgressStatus = 'progressStatus';
  final String colExpiratedAt = 'expiratedAt';
  final String colSpaceId = 'spaceId';
  final String colCreatedBy = 'createdBy';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedBy = 'updatedBy';
  final String colUpdatedAt = 'updatedAt';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblProposals('
      '$colId TEXT PRIMARY KEY, '
      '$colManifestoId TEXT,'
      '$colStatus INTEGER,'
      '$colProgressStatus INTEGER,'
      '$colExpiratedAt TEXT,'
      '$colSpaceId TEXT,'
      '$colCreatedBy TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedBy TEXT,'
      '$colUpdatedAt TEXT)';

  Future<String> insertOrUpdate(Proposal proposal) async {
    Database? db = await this.db;
    Proposal? proposalSaved = await findById(proposal.proposalId);
    if (proposalSaved == null) {
      await db!.insert(tblProposals, proposal.toMap());
      return proposal.proposalId;
    }
    return update(proposal).toString();
  }

  Future<String> insert(Proposal proposal) async {
    Database? db = await this.db;
    Proposal? proposalSaved = await findById(proposal.proposalId);
    if (proposalSaved == null) {
      await db!.insert(tblProposals, proposal.toMap());
      return proposal.proposalId;
    }
    return proposalSaved.proposalId;
  }

  Future<Proposal?> findById(String proposalId) async {
    Database? db = await this.db;
    final result = await db!
        .rawQuery("SELECT * FROM $tblProposals WHERE $colId = '$proposalId'");
    return result.isNotEmpty ? Proposal.fromObject(result[0]) : null;
  }

  Future<int> update(Proposal proposal) async {
    Database? db = await this.db;
    final result = await db!.rawUpdate('UPDATE $tblProposals '
        'SET $colStatus = ${proposal.status.index}'
        ', $colProgressStatus = ${proposal.progressStatus.index}'
        ", $colUpdatedBy = '${proposal.updatedBy}' "
        ", $colUpdatedAt = '${proposal.updatedAt}' "
        "WHERE $colId = '${proposal.proposalId}'");
    return result;
  }
}
