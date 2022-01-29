import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal_participation.repository.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/app_repository.dart';

class ProposalViewsRepository extends AppRepository {
  final tblManifesto = ManifestoRepository().tblManifesto;
  final tblProposals = ProposalRepository().tblProposals;
  final tblProposalParticipations = ProposalParticipationRepository().tblProposalParticipations;
  final colManifestoId = ManifestoRepository().colId;
  final colProposalId = ProposalRepository().colId;
  final colTitle = ManifestoRepository().colTitle;
  final colSpaceId = ManifestoRepository().colSpaceId;
  final colStatus = ProposalRepository().colStatus;
  final colProgressStatus = ProposalRepository().colProgressStatus;
  final colCreatedBy = ManifestoRepository().colCreatedBy;
  final colCreatedAt = ManifestoRepository().colCreatedAt;

  String _getFindBySpaceIdAndStatusQuery(String spaceId, ProposalStatus proposalStatus) {
    return """
      SELECT $tblManifesto.$colManifestoId,
        $colProposalId,
        $colTitle,
        $colSpaceId,
        $tblManifesto.$colCreatedBy,
        $tblManifesto.$colCreatedAt,
        $colStatus,
        $colProgressStatus,
        (
          select count(*) from $tblProposalParticipations
          where $tblProposalParticipations.$colProposalId = $tblProposals.$colProposalId
        ) as "votesCount"
      FROM $tblManifesto
      INNER
        JOIN $tblProposals ON 
            $tblManifesto.$colManifestoId = $tblProposals.$colManifestoId
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
  
  Future<ProposalView?> findOneBySpaceIdAndStatus(String spaceId, ProposalStatus proposalStatus) async {
    Database? db = await this.db;

    final query = _getFindBySpaceIdAndStatusQuery(spaceId, proposalStatus) + '\nLIMIT 1;';
    final result = await db!.rawQuery(query);

    return result.isNotEmpty ? ProposalView.fromObject(result.first) : null;
  }

}
