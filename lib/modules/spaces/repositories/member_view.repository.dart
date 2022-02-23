import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:demos_app/core/repositories/members.repository.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/modules/spaces/models/member.view.dart';
import 'package:sqflite/sqflite.dart';

class MemberViewsRepository extends AppRepository {
  String tblMembers = MembersRepository().tblMembers;
  String tblUsers = UsersRepository().tblUsers;
  String colUserId = MembersRepository().colUserId;
  String colSpaceId = MembersRepository().colSpaceId;
  String colRole = MembersRepository().colRole;
  String colCreatedAt = MembersRepository().colCreatedAt;
  String colName = MembersRepository().colName;
  String colInvitationStatus = MembersRepository().colInvitationStatus;
  String colMemberId = MembersRepository().colId;
  String colInvitationExpiredAt = MembersRepository().colExpiredAt;
  String colProfilePictureKey = UsersRepository().colProfilePictureKey;
  String colPhoneNumber = UsersRepository().colProfilePictureKey;
  String colDeleted = MembersRepository().colDeleted;

  String _getSelectMemberViewQuery() => '''
      SELECT
        $tblMembers.$colUserId,
        $colRole,
        $tblMembers.$colCreatedAt as "memberCreatedAt",
        $tblMembers.$colName as "memberName",
        $colInvitationStatus,
        $colProfilePictureKey,
        $colMemberId,
        $colSpaceId,
        $tblUsers.$colName as "userName",
        $colPhoneNumber,
        $colInvitationExpiredAt as "invitationExpiredAt",
        $colDeleted
      FROM $tblMembers
      INNER
        JOIN $tblUsers ON
            $tblUsers.$colUserId = $tblMembers.$colUserId
  ''';

  Future<MemberView?> findByUserIdAndSpaceId(
      String userId, String spaceId) async {
    Database? db = await this.db;

    final query = """
      ${_getSelectMemberViewQuery()}
      WHERE 
        $tblMembers.$colUserId = '$userId' 
        AND $tblMembers.$colSpaceId = '$spaceId'
        AND $tblMembers.$colDeleted = 0
        AND $tblMembers.$colInvitationStatus = ${InvitationStatus.accepted.index}
        LIMIT 1
    """;
    final result = await db!.rawQuery(query);

    return result.isEmpty ? null : MemberView.fromObject(result.first);
  }
  Future<MemberView> findByMemberId(
      String memberId) async {
    Database? db = await this.db;

    final query = """
      ${_getSelectMemberViewQuery()}
      WHERE 
        $tblMembers.$colMemberId = '$memberId'
        AND $tblMembers.$colDeleted = 0
        AND $tblMembers.$colInvitationStatus = ${InvitationStatus.accepted.index}
    """;
    final result = await db!.rawQuery(query);

    return result.map((row) => MemberView.fromObject(row)).toList().first;
  }
}
