import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal_participation.repository.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/app_repository.dart';

class ProposalViewsRepository extends AppRepository {
  final tblManifesto = ManifestoRepository().tblManifesto;
  final tblProposals = ProposalRepository().tblProposals;
  final tblProposalParticipations = ProposalParticipationRepository().tblProposalParticipations;
  final tblUsers = UsersRepository().tblUsers;
  final colUserId = UsersRepository().colId;
  final colUserName = UsersRepository().colName;
  final colUserProfilePictureKey = UsersRepository().colProfilePictureKey;
  final colManifestoId = ManifestoRepository().colId;
  final colProposalId = ProposalRepository().colId;
  final colTitle = ManifestoRepository().colTitle;
  final colSpaceId = ManifestoRepository().colSpaceId;
  final colStatus = ProposalRepository().colStatus;
  final colProgressStatus = ProposalRepository().colProgressStatus;
  final colCreatedBy = ProposalRepository().colCreatedBy;
  final colUpdatedBy = ProposalRepository().colUpdatedBy;
  final colCreatedAt = ProposalRepository().colCreatedAt;

  String _getFindBySpaceIdAndStatusQuery(String spaceId, ProposalStatus proposalStatus) {
    return """
      SELECT $tblManifesto.$colManifestoId,
        $colProposalId,
        $colTitle,
        $tblProposals.$colCreatedBy,
        $tblProposals.$colCreatedAt,
        $tblProposals.$colSpaceId,
        $colStatus,
        $colProgressStatus,
        $colUserName as "createdByName",
        $colUserProfilePictureKey as "createdByProfilePictureKey",
        (
          select count(*) from $tblProposalParticipations
          where $tblProposalParticipations.$colProposalId = $tblProposals.$colProposalId
        ) as "votesCount"
      FROM $tblManifesto
      INNER
        JOIN $tblProposals ON 
            $tblManifesto.$colManifestoId = $tblProposals.$colManifestoId
      INNER
        JOIN $tblUsers ON
            $tblUsers.$colUserId = $tblProposals.$colUpdatedBy
      WHERE $tblProposals.$colStatus = ${proposalStatus.index}
        AND $tblManifesto.$colSpaceId = '$spaceId'
    """;
  }

   Future<List<ProposalView>> findAllBySpaceIdAndStatus(String spaceId, ProposalStatus proposalStatus) async {
    Database? db = await this.db;

    final query = _getFindBySpaceIdAndStatusQuery(spaceId, proposalStatus);
    final result = await db!.rawQuery(query);

    return result.map((row) => ProposalView.fromObject(row)).toList();
  }

  Future<int> getCountBySpaceIdAndStatus(String spaceId, ProposalStatus proposalStatus) async {
    Database? db = await this.db;

    final result = await db!.rawQuery(
      """
       select count(*) as count from $tblProposals
          where $colSpaceId = '$spaceId' AND $colStatus = ${proposalStatus.index}
      """
    );

    return result.isNotEmpty ? int.parse(result.first['count'].toString()) : 0;
  }

}
