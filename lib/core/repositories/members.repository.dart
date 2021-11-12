import 'dart:io';
import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/enums/space-role.enum.dart';
import 'package:demos_app/core/models/member.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MembersRepository {
  static final MembersRepository _memberRepository =
      MembersRepository._internal();
  String tblMembers = "member";
  String colId = "memberId";
  String colSpaceId = "spaceId";
  String colUserId = "userId";
  String colInvitationStatus = "invitationStatus";
  String colName = "name";
  String colRole = "role";
  String colExpiredAt = "expiredAt";
  String colDeleted = "deleted";
  String colCreatedBy = "createdBy";
  String colUpdatedBy = "updatedBy";
  String colCreatedAt = "createdAt";
  String colUpdatedAt = "updatedAt";

  MembersRepository._internal();

  factory MembersRepository() {
    return _memberRepository;
  }

  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializaDb();
    }
    return _db;
  }

  Future<Database> initializaDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "member.db";
    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $tblMembers(" +
        "$colId TEXT PRIMARY KEY, " +
        "$colSpaceId TEXT, " +
        "$colUserId TEXT," +
        "$colInvitationStatus INTEGER," +
        "$colRole TEXT," +
        "$colName TEXT," +
        "$colExpiredAt TEXT," +
        "$colDeleted BOOLEAN," +
        "$colCreatedBy TEXT," +
        "$colUpdatedBy TEXT," +
        "$colCreatedAt TEXT," +
        "$colUpdatedAt TEXT)");
  }

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
    var result = await db!
        .rawQuery("SELECT * FROM $tblMembers WHERE $colId = '$memberId'");
    return result.length > 0 ? Member.fromObject(result[0]) : null;
  }

   Future<Member?> findByUserIdAndSpaceId(
      String userId, String spaceId) async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblMembers WHERE $colUserId = '$userId' AND $colSpaceId = '$spaceId'");
    return result.length > 0 ? Member.fromObject(result[0]) : null;
  }

  Future<List<Member>> findBySpaceIdAndInvitationStatus(
      String? spaceId, InvitationStatus invitationStatus) async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblMembers WHERE $colSpaceId = '$spaceId' AND $colInvitationStatus = ${invitationStatus.index}");
    return result.map((row) => Member.fromObject(row)).toList();
  }

  Future<List<Member>> findByInvitationStatusAndUserId(
      InvitationStatus invitationStatus, String userId) async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblMembers WHERE $colInvitationStatus = ${invitationStatus.index} AND $colUserId = '$userId'");
    return result.map((row) => Member.fromObject(row)).toList();
  }

  Future<List<Member>> findBySpaceId(String? spaceId) async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblMembers WHERE $colSpaceId = '$spaceId'");
    return result.map((row) => Member.fromObject(row)).toList();
  }

  Future<int> update(Member member) async {
    Database? db = await this.db;
    var result = await db!.rawUpdate("UPDATE $tblMembers " +
        "SET $colInvitationStatus = '${member.invitationStatus?.index}'" +
        ", $colRole = '${getSpaceRoleString(member.role)}' " +
        ", $colName = '${member.name ?? ''}' " +
        ", $colDeleted = ${member.deleted ? 0 : 1} " +
        ", $colUpdatedBy = '${member.updatedBy}' " +
        "WHERE $colId = '${member.memberId}'");
    return result;
  }
}
