import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:demos_app/core/repositories/members.repository.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:sqflite/sqflite.dart';

class SpaceViewsRepository extends AppRepository {
  String tblSpaces = SpacesRepository().tblSpaces;
  String tblMembers = MembersRepository().tblMembers;
  String colSpaceId = SpacesRepository().colId;
  String colSpaceName = SpacesRepository().colName;
  String colDescription = SpacesRepository().colDescription;
  String colPictureKey = SpacesRepository().colPictureKey;
  String colApprovalPercentage = SpacesRepository().colApprovalPercentage;
  String colParticipationPercentage = SpacesRepository().colParticipationPercentage;
  String colInvitationStatus = MembersRepository().colInvitationStatus;
  String colCreatedAt = MembersRepository().colCreatedAt;
  String colUserId = MembersRepository().colUserId;
  String colDeleted = MembersRepository().colDeleted;

  String _getSelectSpacesQuery() => '''
      SELECT $tblSpaces.$colSpaceId,
        $tblSpaces.$colSpaceName,
        $colPictureKey,
        $colDescription,
        $colApprovalPercentage,
        $colParticipationPercentage,
        $tblSpaces.$colCreatedAt,
        (
          select count(*) from $tblMembers
          where $tblMembers.$colSpaceId = $tblSpaces.$colSpaceId AND $colInvitationStatus = ${InvitationStatus.accepted.index}
        ) as "membersCount"
      FROM $tblSpaces
      INNER
        JOIN $tblMembers ON 
            $tblSpaces.$colSpaceId = $tblMembers.$colSpaceId
    ''';

  String _getSelectSpacesByUserIdQuery(String userId) => '''
      ${_getSelectSpacesQuery()}
      WHERE $colInvitationStatus = ${InvitationStatus.accepted.index} AND $colUserId = '$userId' AND $colDeleted = 0
    ''';

  Future<List<SpaceView>> findByUserId(String userId) async {
    Database? db = await this.db;

    final query = _getSelectSpacesByUserIdQuery(userId);
    final result = await db!.rawQuery(query);

    return result.map((row) => SpaceView.fromObject(row)).toList();
  }

    String _getSelectOneSpaceBySpaceIdQuery(String spaceId) => '''
      ${_getSelectSpacesQuery()}
      WHERE $colInvitationStatus = ${InvitationStatus.accepted.index} AND $tblSpaces.$colSpaceId  = '$spaceId' AND $colDeleted = 0
      LIMIT 1
    ''';

  Future<SpaceView> findById(String spaceId) async {
    Database? db = await this.db;

    final query = _getSelectOneSpaceBySpaceIdQuery(spaceId);
    final result = await db!.rawQuery(query);

    return SpaceView.fromObject(result.first);
  }
}
