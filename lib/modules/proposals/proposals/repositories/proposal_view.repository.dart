import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal.repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:demos_app/modules/proposals/proposals/models/proposal_view.model.dart';

class ProposalViewsRepository extends AppRepository {
  final tbManifesto = ManifestoRepository().tbManifesto;
  final tbProposals = ProposalRepository().tbProposals;
  final colManifestoId = ManifestoRepository().colId;
  final colTitle = ManifestoRepository().colTitle;
  final colSpaceId = ManifestoRepository().colSpaceId;
  final colStatus = ProposalRepository().colStatus;
  final colProgressStatus = ProposalRepository().colProgressStatus;
  final colCreatedBy = ManifestoRepository().colCreatedBy;
  final colCreatedAt = ManifestoRepository().colCreatedAt;

  Future<List<ProposalView>> findDraftsBySpaceId(String spaceId) async {
    Database? db = await this.db;

    final proposalStatus = ProposalStatus.draft.index;

    final result = await db!.rawQuery("""
      SELECT $tbManifesto.$colManifestoId,
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
      WHERE $tbProposals.$colStatus = $proposalStatus
        AND $tbManifesto.$colSpaceId = '$spaceId';
    """);

    return result.map((row) => ProposalView.fromObject(row)).toList();
  }

  Future<ProposalView?> findOneDraftsBySpaceId(String spaceId) async {
    Database? db = await this.db;

    final proposalStatus = ProposalStatus.draft.index;

    final result = await db!.rawQuery("""
      SELECT $tbManifesto.$colManifestoId,
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
      WHERE $tbProposals.$colStatus = $proposalStatus
        AND $tbManifesto.$colSpaceId = '$spaceId'
      LIMIT 1;
    """);

    return result.isNotEmpty ? ProposalView.fromObject(result.first) : null;
  }
}
