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

import 'package:demos_app/utils/secure_sql_string.util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/enums/space_role.enum.dart';
import 'package:demos_app/core/models/member.model.dart';

class MembersRepository extends AppRepository implements Table {
  static final MembersRepository _memberRepository =
      MembersRepository._internal();
  final String tblMembers = 'member';
  final String colId = 'memberId';
  final String colSpaceId = 'spaceId';
  final String colUserId = 'userId';
  final String colInvitationStatus = 'invitationStatus';
  final String colName = 'name';
  final String colRole = 'role';
  final String colExpiredAt = 'expiredAt';
  final String colDeleted = 'deleted';
  final String colCreatedBy = 'createdBy';
  final String colUpdatedBy = 'updatedBy';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedAt = 'updatedAt';

  MembersRepository._internal();

  factory MembersRepository() {
    return _memberRepository;
  }

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblMembers('
      '$colId TEXT PRIMARY KEY, '
      '$colSpaceId TEXT, '
      '$colUserId TEXT,'
      '$colInvitationStatus INTEGER,'
      '$colRole TEXT,'
      '$colName TEXT,'
      '$colExpiredAt TEXT,'
      '$colDeleted BOOLEAN,'
      '$colCreatedBy TEXT,'
      '$colUpdatedBy TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedAt TEXT)';

  Future<String> insertOrUpdate(Member member) async {
    Database? db = await this.db;
    Member? memberSaved = await findById(member.memberId);
    if (memberSaved == null) {
      await db!.insert(tblMembers, member.toMap());
      return member.memberId;
    }
    return update(member).toString();
  }

  Future<String> insert(Member member) async {
    Database? db = await this.db;
    Member? memberSaved = await findById(member.memberId);
    if (memberSaved == null) {
      await db!.insert(tblMembers, member.toMap());
      return member.memberId;
    }
    return memberSaved.memberId;
  }

  Future<Member?> findById(String memberId) async {
    Database? db = await this.db;
    final result = await db!.rawQuery(
        "SELECT * FROM $tblMembers WHERE $colId = '$memberId' AND $colDeleted = 0");
    return result.isNotEmpty ? Member.fromObject(result[0]) : null;
  }

  Future<Member?> findByUserIdAndSpaceIdAndInvitationStatuses(String userId,
      String spaceId, List<InvitationStatus> invitationStatus) async {
    Database? db = await this.db;
    final String status = invitationStatus.map((i) => i.index).join(', ');

    final result = await db!.rawQuery(
        "SELECT * FROM $tblMembers WHERE  $colUserId = '$userId' AND $colInvitationStatus IN($status) AND $colSpaceId = '$spaceId' AND $colDeleted = 0");

    return result.isNotEmpty ? Member.fromObject(result[0]) : null;
  }

  Future<Member?> findByUserIdAndSpaceIdAndInvitationStatusAccepted(
      String userId, String spaceId) async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblMembers WHERE $colUserId = '$userId' AND $colSpaceId = '$spaceId' AND $colDeleted = 0 AND $colInvitationStatus = ${InvitationStatus.accepted.index}");
    return result.isNotEmpty ? Member.fromObject(result[0]) : null;
  }

  Future<int> update(Member member) async {
    Database? db = await this.db;
    final result = await db!.rawUpdate('UPDATE $tblMembers '
        "SET $colInvitationStatus = '${member.invitationStatus.index}'"
        ", $colRole = '${getSpaceRoleString(member.role)}' "
        ", $colName = '${secureSQLString(member.name)}' "
        ', $colDeleted = ${member.deleted ? 1 : 0} '
        ", $colUpdatedBy = '${member.updatedBy}' "
        "WHERE $colId = '${member.memberId}'");
    return result;
  }

  Future<List<Member>> findRepresentativesBySpaceId(String spaceId) async {
    Database? db = await this.db;
    final String representative = getSpaceRoleString(SpaceRole.representative);

    final result = await db!.rawQuery(
        "SELECT * FROM $tblMembers WHERE $colRole = '$representative' AND $colSpaceId = '$spaceId' AND $colDeleted = 0");

    return result.map((row) => Member.fromObject(row)).toList();
  }

  Future<List<Member>> findAdministratorsBySpaceId(String spaceId) async {
    Database? db = await this.db;
    final String admin = getSpaceRoleString(SpaceRole.admin);

    final result = await db!.rawQuery(
        "SELECT * FROM $tblMembers WHERE $colRole = '$admin' AND $colSpaceId = '$spaceId' AND $colDeleted = 0");

    return result.map((row) => Member.fromObject(row)).toList();
  }
}
