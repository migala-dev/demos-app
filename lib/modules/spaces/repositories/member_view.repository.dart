/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal_participation.repository.dart';
import 'package:demos_app/core/repositories/members.repository.dart';
import 'package:demos_app/core/repositories/users.repository.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:sqflite/sqflite.dart';

class MemberViewsRepository extends AppRepository {
  String tblMembers = MembersRepository().tblMembers;
  String tblUsers = UsersRepository().tblUsers;
  String tblProposalParticipation = ProposalParticipationRepository().tblProposalParticipations;
  String tblProposals = ProposalRepository().tblProposals;
  String colUserId = MembersRepository().colUserId;
  String colSpaceId = MembersRepository().colSpaceId;
  String colRole = MembersRepository().colRole;
  String colCreatedAt = MembersRepository().colCreatedAt;
  String colName = MembersRepository().colName;
  String colInvitationStatus = MembersRepository().colInvitationStatus;
  String colMemberId = MembersRepository().colId;
  String colInvitationExpiredAt = MembersRepository().colExpiredAt;
  String colProfilePictureKey = UsersRepository().colProfilePictureKey;
  String colDeleted = MembersRepository().colDeleted;
  String colParticipated = ProposalParticipationRepository().colParticipated;
  String colCreatedBy = ProposalRepository().colCreatedBy;
  String colProposalStatus = ProposalRepository().colStatus;

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
        $colInvitationExpiredAt as "invitationExpiredAt",
        $colDeleted,
        (
          select count(*) from $tblProposalParticipation
          where $tblProposalParticipation.$colMemberId = $tblMembers.$colMemberId AND $colParticipated = 1
        ) as "proposalVotedCount",
        (
          select count(*) from $tblProposals
          where $tblProposals.$colCreatedBy = $tblMembers.$colUserId AND $colProposalStatus != ${ProposalStatus.draft.index}
        ) as "proposalCreatedCount"
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

  Future<List<MemberView>> findMembersBySpaceId(String spaceId) async {
    Database? db = await this.db;
    final String validStatus = '${InvitationStatus.accepted.index}, '
        '${InvitationStatus.sended.index}, '
        '${InvitationStatus.received.index}';

    final query = """
      ${_getSelectMemberViewQuery()}
      WHERE 
        $tblMembers.$colSpaceId = '$spaceId'
        AND $tblMembers.$colDeleted = 0
        AND $tblMembers.$colInvitationStatus IN($validStatus)
    """;
    final result = await db!.rawQuery(query);

    return result.map((row) => MemberView.fromObject(row)).toList();
  }
}
