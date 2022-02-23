import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:demos_app/core/repositories/members.repository.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/modules/spaces/models/invitation_view.model.dart';
import 'package:sqflite/sqflite.dart';

class InvitationViewsRepository extends AppRepository {
  String tblSpaces = SpacesRepository().tblSpaces;
  String tblMembers = MembersRepository().tblMembers;
  String tblUsers = UsersRepository().tblUsers;
  String colSpaceId = SpacesRepository().colId;
  String colName = SpacesRepository().colName;
  String colPictureKey = SpacesRepository().colPictureKey;
  String colInvitationStatus = MembersRepository().colInvitationStatus;
  String colCreatedAt = MembersRepository().colCreatedAt;
  String colExpiredAt = MembersRepository().colExpiredAt;
  String colCreatedBy = MembersRepository().colCreatedBy;
  String colUserId = MembersRepository().colUserId;
  String colDeleted = MembersRepository().colDeleted;
  String colPhoneNumber = UsersRepository().colPhoneNumber;
  String colProfilePictureKey = UsersRepository().colProfilePictureKey;
  String colUpdatedAt = UsersRepository().colUpdatedAt;
  String colMemberId = MembersRepository().colId;

  String _getSelectQuery() {
    return '''
      SELECT $tblSpaces.$colSpaceId,
        $tblSpaces.$colName as "spaceName",
        $colPictureKey,
        $tblMembers.$colCreatedAt as "memberCreateAt",
        $colExpiredAt,
        $tblUsers.$colUserId,
        $tblUsers.$colName,
        $tblUsers.$colPhoneNumber,
        $tblUsers.$colProfilePictureKey,
        $tblUsers.$colCreatedAt,
        $tblUsers.$colUpdatedAt
      FROM $tblSpaces
      INNER
        JOIN $tblMembers ON 
            $tblSpaces.$colSpaceId = $tblMembers.$colSpaceId
      INNER
        JOIN $tblUsers ON
          $tblMembers.$colCreatedBy = $tblUsers.$colUserId''';
  }

  String _getFindAllSpacesByUserIdQuery(String userId) {
    final String invitationStatus = '${InvitationStatus.sended.index},'
        '${InvitationStatus.received.index}';

    return '''
      ${_getSelectQuery()}
      WHERE $colInvitationStatus IN($invitationStatus) AND $tblMembers.$colUserId = '$userId' AND $colDeleted = 0
    ''';
  }

  Future<List<InvitationView>> getInvitationsByUserId(String userId) async {
    Database? db = await this.db;

    final query = _getFindAllSpacesByUserIdQuery(userId);
    final result = await db!.rawQuery(query);

    return result.map((row) => InvitationView.fromObject(row)).toList();
  }

  String _getFindAllSpacesByMemberIdQuery(String memberId) {
    final String invitationStatus = '${InvitationStatus.sended.index},'
        '${InvitationStatus.received.index}';

    return '''
      ${_getSelectQuery()}
      WHERE $colInvitationStatus IN($invitationStatus) AND $tblMembers.$colMemberId = '$memberId' AND $colDeleted = 0
      LIMIT 1
    ''';
  }

  Future<InvitationView> getInvitationByMemberId(String memberId) async {
    Database? db = await this.db;

    final query = _getFindAllSpacesByMemberIdQuery(memberId);
    final result = await db!.rawQuery(query);

    return InvitationView.fromObject(result.first);
  }
}
