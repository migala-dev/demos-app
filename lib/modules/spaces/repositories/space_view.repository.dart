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
  String colPictureKey = SpacesRepository().colPictureKey;
  String colInvitationStatus = MembersRepository().colInvitationStatus;
  String colUserId = MembersRepository().colUserId;
  String colDeleted = MembersRepository().colDeleted;

  String _getFindAllSpacesByUserIdQuery(String userId) {
    return '''
      SELECT $tblSpaces.$colSpaceId,
        $tblSpaces.$colSpaceName,
        $colPictureKey,
        (
          select count(*) from $tblMembers
          where $tblMembers.$colSpaceId = $tblSpaces.$colSpaceId AND $colInvitationStatus = ${InvitationStatus.accepted.index}
        ) as "membersCount"
      FROM $tblSpaces
      INNER
        JOIN $tblMembers ON 
            $tblSpaces.$colSpaceId = $tblMembers.$colSpaceId
      WHERE $colInvitationStatus = ${InvitationStatus.accepted.index} AND $colUserId = '$userId' AND $colDeleted = 0
    ''';
  }

  Future<List<SpaceView>> getSpacesByUserId(String userId) async {
    Database? db = await this.db;

    final query = _getFindAllSpacesByUserIdQuery(userId);
    final result = await db!.rawQuery(query);

    return result.map((row) => SpaceView.fromObject(row)).toList();
  }
}
