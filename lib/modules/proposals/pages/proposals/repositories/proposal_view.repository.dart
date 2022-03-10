import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto_option.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal_participation.repository.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/modules/proposals/pages/proposals/models/proposal_view.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/app_repository.dart';

class ProposalViewsRepository extends AppRepository {
  final tblManifesto = ManifestoRepository().tblManifesto;
  final tblProposals = ProposalRepository().tblProposals;
  final tblProposalParticipations =
      ProposalParticipationRepository().tblProposalParticipations;
  final tblManifestoOptions = ManifestoOptionRepository().tblManifestoOptions;
  final tblUsers = UsersRepository().tblUsers;
  final colUserId = UsersRepository().colId;
  final colUserName = UsersRepository().colName;
  final colUserProfilePictureKey = UsersRepository().colProfilePictureKey;
  final colManifestoId = ManifestoRepository().colId;
  final colProposalId = ProposalRepository().colId;
  final colTitle = ManifestoRepository().colTitle;
  final colContent = ManifestoRepository().colContent;
  final colOptionType = ManifestoRepository().colOptionType;
  final colSpaceId = ManifestoRepository().colSpaceId;
  final colStatus = ProposalRepository().colStatus;
  final colProgressStatus = ProposalRepository().colProgressStatus;
  final colCreatedBy = ProposalRepository().colCreatedBy;
  final colUpdatedBy = ProposalRepository().colUpdatedBy;
  final colCreatedAt = ProposalRepository().colCreatedAt;
  final colManifestoOptionId = ManifestoOptionRepository().colId;

  String _getSelectInnerJoinQuery() => '''
    SELECT $tblManifesto.$colManifestoId,
            $colProposalId,
            $colTitle,
            $colContent,
            $colOptionType,
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
  ''';

  String _getFindByProposalIdQuery(String proposalId) => '''
    ${_getSelectInnerJoinQuery()}
    WHERE $colProposalId = '$proposalId'
  ''';

  String _getFindBySpaceIdAndStatusQuery(
      String spaceId, ProposalStatus proposalStatus) {
    return """
      ${_getSelectInnerJoinQuery()}
      WHERE $tblProposals.$colStatus = ${proposalStatus.index}
        AND $tblManifesto.$colSpaceId = '$spaceId'
    """;
  }

  String _getManifestoOptionsQuery(String manifestoId) => """
    SELECT 
      $colManifestoOptionId,
      $colTitle
    FROM $tblManifestoOptions
    WHERE $colManifestoId = '$manifestoId'
  """;

  Future<List<Map<String, Object?>>> _getResultWithManifestoOptions(
      List<Map<String, Object?>> result) async {
    final Database? db = await this.db;

    List<Map<String, Object?>> resultWithManifestoOptions =
        result.map((r) => {...r}).toList();
    for (Map<String, Object?> row in resultWithManifestoOptions) {
      final String manifestoOptionsQuery =
          _getManifestoOptionsQuery(row['manifestoId'].toString());
      final manifestoOptionsResult = await db!.rawQuery(manifestoOptionsQuery);

      row['manifestoOptions'] = manifestoOptionsResult;
    }

    return resultWithManifestoOptions;
  }

  Future<ProposalView?> findByProposalId(String proposalId) async {
    Database? db = await this.db;
    final result = await db!.rawQuery(_getFindByProposalIdQuery(proposalId));
    List<Map<String, Object?>> resultWithManifestoOptions =
        await _getResultWithManifestoOptions(result);

    return resultWithManifestoOptions.isNotEmpty
        ? ProposalView.fromObject(resultWithManifestoOptions[0])
        : null;
  }

  Future<List<ProposalView>> findAllBySpaceIdAndStatus(
      String spaceId, ProposalStatus proposalStatus) async {
    Database? db = await this.db;

    final query = _getFindBySpaceIdAndStatusQuery(spaceId, proposalStatus);
    final result = await db!.rawQuery(query);

    List<Map<String, Object?>> resultWithManifestoOptions =
        await _getResultWithManifestoOptions(result);

    return resultWithManifestoOptions
        .map((row) => ProposalView.fromObject(row))
        .toList();
  }

  Future<int> getCountBySpaceIdAndStatus(
      String spaceId, ProposalStatus proposalStatus) async {
    Database? db = await this.db;

    final result = await db!.rawQuery("""
       select count(*) as count from $tblProposals
          where $colSpaceId = '$spaceId' AND $colStatus = ${proposalStatus.index}
      """);

    return result.isNotEmpty ? int.parse(result.first['count'].toString()) : 0;
  }
}
