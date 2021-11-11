import 'dart:io';
import 'package:demos_app/core/models/role_user_space.model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class RoleUserSpaceRepository {
  static final RoleUserSpaceRepository _roleUserSpaceRepository =
      RoleUserSpaceRepository._internal();
  String tblRoleUserSpaces = "roleUserSpace";
  String colId = "roleUserSpaceId";
  String colSpaceId = "spaceId";
  String colUserId = "userId";
  String colRole = "role";
  String colDeleted = "deleted";
  String colCreatedBy = "createdBy";
  String colUpdatedBy = "updatedBy";
  String colCreatedAt = "createdAt";
  String colUpdatedAt = "updatedAt";

  RoleUserSpaceRepository._internal();

  factory RoleUserSpaceRepository() {
    return _roleUserSpaceRepository;
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
    String path = dir.path + "role_user_space.db";
    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $tblRoleUserSpaces(" +
        "$colId TEXT PRIMARY KEY, " +
        "$colSpaceId TEXT, " +
        "$colUserId TEXT," +
        "$colRole TEXT," +
        "$colDeleted BOOLEAN," +
        "$colCreatedBy TEXT," +
        "$colUpdatedBy TEXT," +
        "$colCreatedAt TEXT," +
        "$colUpdatedAt TEXT)");
  }

  Future<String> insert(RoleUserSpace roleUserSpace) async {
    Database? db = await this.db;
    RoleUserSpace? spaceSaved = await findById(roleUserSpace.roleUserSpaceId!);
    if (spaceSaved == null) {
      await db!.insert(tblRoleUserSpaces, roleUserSpace.toMap());
      return roleUserSpace.roleUserSpaceId!;
    }
    return spaceSaved.roleUserSpaceId!;
  }

  Future<RoleUserSpace?> findById(String roleUserSpaceId) async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblRoleUserSpaces WHERE $colId = '$roleUserSpaceId'");
    return result.length > 0 ? RoleUserSpace.fromObject(result[0]) : null;
  }

  Future<RoleUserSpace?> findByUserIdAndSpaceId(
      String userId, String spaceId) async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblRoleUserSpaces WHERE $colUserId = '$userId' AND $colSpaceId = '$spaceId'");
    return result.length > 0 ? RoleUserSpace.fromObject(result[0]) : null;
  }

  Future<List<RoleUserSpace>> getAll() async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblRoleUserSpaces ORDER BY $colCreatedAt ASC");
    return result.map((row) => RoleUserSpace.fromObject(row)).toList();
  }

  Future<int> updateSpace(RoleUserSpace roleUserSpace) async {
    Database? db = await this.db;
    var result = await db!.rawUpdate("UPDATE $tblRoleUserSpaces " +
        "SET $colRole = '${roleUserSpace.role}'" +
        ", $colDeleted = '${roleUserSpace.deleted}' " +
        ", $colUpdatedBy = '${roleUserSpace.updatedBy}' " +
        "WHERE $colId = '${roleUserSpace.roleUserSpaceId}'");
    return result;
  }

  Future<int> deleteSpace(String? roleUserSpaceId) async {
    int result;
    Database? db = await this.db;
    result = await db!.rawDelete(
        'DELETE FROM $tblRoleUserSpaces where $colId = $roleUserSpaceId');
    return result;
  }
}
