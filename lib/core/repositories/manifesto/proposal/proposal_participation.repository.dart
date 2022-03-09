import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/models/manifesto/proposal/proposal_participation.model.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:sqflite/sqflite.dart';

class ProposalParticipationRepository extends AppRepository implements Table {
  final String tblProposalParticipations = 'proposalParticipations';
  final String colId = 'proposalParticipationId';
  final String colUserId = 'userId';
  final String colProposalId = 'proposalId';
  final String colMemberId = 'memberId';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblProposalParticipations('
      '$colId TEXT PRIMARY KEY, '
      '$colUserId TEXT,'
      '$colProposalId TEXT,'
      '$colMemberId TEXT)';


  Future<String> insert(ProposalParticipation proposalParticipation) async {
    Database? db = await this.db;
    ProposalParticipation? proposalParticipationSaved = await findById(proposalParticipation.proposalParticipationId);
    if (proposalParticipationSaved == null) {
      await db!.insert(tblProposalParticipations, proposalParticipation.toMap());
      return proposalParticipation.proposalParticipationId;
    }
    return proposalParticipation.proposalParticipationId;
  }

  Future<ProposalParticipation?> findById(String proposalParticipationId) async {
    Database? db = await this.db;
    final result =
        await db!.rawQuery("SELECT * FROM $tblProposalParticipations WHERE $colId = '$proposalParticipationId'");
    return result.isNotEmpty ? ProposalParticipation.fromObject(result[0]) : null;
  }

}
