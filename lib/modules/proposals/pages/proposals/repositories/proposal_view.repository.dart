import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal.repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';

class ProposalViewsRepository extends AppRepository {
  final tbManifesto = ManifestoRepository().tbManifesto;
  final tbProposals = ProposalRepository().tbProposals;
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
      SELECT $tbManifesto.$colManifestoId,
        $colProposalId,
        $colTitle,
        $colSpaceId,
        $tbManifesto.$colCreatedBy,
        $tbManifesto.$colCreatedAt,
        $colStatus,
        $colProgressStatus
      FROM $tbManifesto
      INNER
        JOIN $tbProposals ON 
            $tbManifesto.$colManifestoId = $tbProposals.$colManifestoId
      WHERE $tbProposals.$colStatus = ${proposalStatus.index}
        AND $tbManifesto.$colSpaceId = '$spaceId'
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
