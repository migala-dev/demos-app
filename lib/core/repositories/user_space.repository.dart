import 'dart:io';
import 'package:demos_app/core/enums/invitation-status.enum.dart';
import 'package:demos_app/core/models/user_space.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class UserSpaceRepository {
  static final UserSpaceRepository _userSpaceRepository =
      UserSpaceRepository._internal();
  String tblUserSpaces = "userSpace";
  String colId = "userSpaceId";
  String colSpaceId = "spaceId";
  String colUserId = "userId";
  String colInvitationStatus = "invitationStatus";
  String colDeleted = "deleted";
  String colCreatedBy = "createdBy";
  String colUpdatedBy = "updatedBy";
  String colCreatedAt = "createdAt";
  String colUpdatedAt = "updatedAt";

  UserSpaceRepository._internal();

  factory UserSpaceRepository() {
    return _userSpaceRepository;
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
    String path = dir.path + "user_space.db";
    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $tblUserSpaces(" +
        "$colId TEXT PRIMARY KEY, " +
        "$colSpaceId TEXT, " +
        "$colUserId TEXT," +
        "$colInvitationStatus INTEGER," +
        "$colDeleted BOOLEAN," +
        "$colCreatedBy TEXT," +
        "$colUpdatedBy TEXT," +
        "$colCreatedAt TEXT," +
        "$colUpdatedAt TEXT)");
  }

  Future<String> insertOrUpdate(UserSpace userSpace) async {
    Database? db = await this.db;
    UserSpace? spaceSaved = await findById(userSpace.userSpaceId!);
    if (spaceSaved == null) {
      await db!.insert(tblUserSpaces, userSpace.toMap());
      return userSpace.userSpaceId!;
    }
    return update(userSpace).toString();
  }


  Future<String> insert(UserSpace userSpace) async {
    Database? db = await this.db;
    UserSpace? spaceSaved = await findById(userSpace.userSpaceId!);
    if (spaceSaved == null) {
      await db!.insert(tblUserSpaces, userSpace.toMap());
      return userSpace.userSpaceId!;
    }
    return spaceSaved.userSpaceId!;
  }

  Future<UserSpace?> findById(String userSpaceId) async {
    Database? db = await this.db;
    var result = await db!
        .rawQuery("SELECT * FROM $tblUserSpaces WHERE $colId = '$userSpaceId'");
    return result.length > 0 ? UserSpace.fromObject(result[0]) : null;
  }

  Future<List<UserSpace>> findBySpaceIdAndInvitationStatus(
      String? spaceId, InvitationStatus invitationStatus) async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblUserSpaces WHERE $colSpaceId = '$spaceId' AND $colInvitationStatus = ${invitationStatus.index}");
    return result.map((row) => UserSpace.fromObject(row)).toList();
  }

  Future<List<UserSpace>> getAll() async {
    Database? db = await this.db;
    var result = await db!
        .rawQuery("SELECT * FROM $tblUserSpaces ORDER BY $colCreatedAt ASC");
    return result.map((row) => UserSpace.fromObject(row)).toList();
  }

  Future<List<UserSpace>> findByInvitationStatus(
      InvitationStatus invitationStatus) async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblUserSpaces WHERE $colInvitationStatus = ${invitationStatus.index}");
    return result.map((row) => UserSpace.fromObject(row)).toList();
  }

  Future<List<UserSpace>> findBySpaceId(String? spaceId) async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblUserSpaces WHERE $colSpaceId = '$spaceId'");
    return result.map((row) => UserSpace.fromObject(row)).toList();
  }

  Future<int> update(UserSpace userSpace) async {
    Database? db = await this.db;
    var result = await db!.rawUpdate("UPDATE $tblUserSpaces " +
        "SET $colInvitationStatus = '${userSpace.invitationStatus?.index}'" +
        ", $colDeleted = '${userSpace.deleted}' " +
        ", $colUpdatedBy = '${userSpace.updatedBy}' " +
        "WHERE $colId = '${userSpace.userSpaceId}'");
    return result;
  }

  Future<int> deleteSpace(String? userSpaceId) async {
    int result;
    Database? db = await this.db;
    result = await db!
        .rawDelete('DELETE FROM $tblUserSpaces where $colId = $userSpaceId');
    return result;
  }
}
