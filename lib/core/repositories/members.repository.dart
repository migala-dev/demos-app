import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';
import 'package:demos_app/core/models/member.model.dart';
import 'package:demos_app/core/repositories/demos_table.repository.dart';

class MembersRepository extends DemosTable {
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
    Member? memberSaved = await findById(member.memberId!);
    if (memberSaved == null) {
      await db!.insert(tblMembers, member.toMap());
      return member.memberId!;
    }
    return update(member).toString();
  }

  Future<String> insert(Member member) async {
    Database? db = await this.db;
    Member? memberSaved = await findById(member.memberId!);
    if (memberSaved == null) {
      await db!.insert(tblMembers, member.toMap());
      return member.memberId!;
    }
    return memberSaved.memberId!;
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

  Future<List<Member>> findBySpaceIdAndInvitationStatus(
      String? spaceId, InvitationStatus invitationStatus) async {
    Database? db = await this.db;
    final result = await db!.rawQuery(
        "SELECT * FROM $tblMembers WHERE $colSpaceId = '$spaceId' AND $colInvitationStatus = ${invitationStatus.index} AND $colDeleted = 0");
    return result.map((row) => Member.fromObject(row)).toList();
  }

  Future<List<Member>> findByInvitationStatusAndUserId(
      InvitationStatus invitationStatus, String userId) async {
    Database? db = await this.db;
    final result = await db!.rawQuery(
        "SELECT * FROM $tblMembers WHERE $colInvitationStatus = ${invitationStatus.index} AND $colUserId = '$userId' AND $colDeleted = 0");
    return result.map((row) => Member.fromObject(row)).toList();
  }

  Future<List<Member>> findMembersAndInvitationsBySpaceId(
      String? spaceId) async {
    Database? db = await this.db;
    final String validStatus = '${InvitationStatus.accepted.index}, '
        '${InvitationStatus.sended.index}, '
        '${InvitationStatus.received.index}';
    final result = await db!.rawQuery('SELECT * FROM $tblMembers '
        "WHERE $colSpaceId = '$spaceId' AND $colDeleted = 0 "
        'AND $colInvitationStatus IN($validStatus)');
    return result.map((row) => Member.fromObject(row)).toList();
  }

  Future<int> update(Member member) async {
    Database? db = await this.db;
    final result = await db!.rawUpdate('UPDATE $tblMembers '
        "SET $colInvitationStatus = '${member.invitationStatus?.index}'"
        ", $colRole = '${getSpaceRoleString(member.role)}' "
        ", $colName = '${member.name ?? ''}' "
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

  Future<List<Member>> findInvitedMembersBySpaceId(String spaceId) async {
    Database? db = await this.db;
    final String aceptedStatus = '${InvitationStatus.accepted.index},'
        '${InvitationStatus.sended.index},'
        '${InvitationStatus.received.index}';

    final result = await db!.rawQuery(
        "SELECT * FROM $tblMembers WHERE $colInvitationStatus IN($aceptedStatus) AND $colSpaceId = '$spaceId'");

    return result.map((row) => Member.fromObject(row)).toList();
  }
}
