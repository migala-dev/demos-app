import 'dart:io';

import 'package:demos_app/core/models/user.model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class UsersRepository {
  static final UsersRepository _usersRepository = UsersRepository._internal();
  String tblUsers = "user";
  String colId = "userId";
  String colName = "name";
  String colPhoneNumber = "phoneNumber";
  String colProfilePictureKey = "profilePictureKey";
  String colCreatedAt = "createdAt";
  String colUpdatedAt = "updatedAt";

  UsersRepository._internal();

  factory UsersRepository() {
    return _usersRepository;
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
    String path = dir.path + "users.db";
    var dbUsers = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbUsers;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $tblUsers(" +
        "$colId TEXT PRIMARY KEY, " +
        "$colName TEXT, " +
        "$colPhoneNumber TEXT UNIQUE," +
        "$colProfilePictureKey TEXT," +
        "$colCreatedAt TEXT," +
        "$colUpdatedAt TEXT)");
  }

  Future<String> insert(User user) async {
    Database? db = await this.db;
    User? userSaved = await findById(user.userId!);
    if (userSaved == null) {
      await db!.insert(tblUsers, user.toMap());
      return user.userId!;
    }
    return userSaved.userId!;
  }

  Future<User?> getUserByPhoneNumber(String phoneNumber) async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblUsers WHERE $colPhoneNumber LIKE '%$phoneNumber'");
    return result.length > 0 ? User.fromObject(result[0]) : null;
  }

  Future<User?> findById(String userId) async {
    Database? db = await this.db;
    var result =
        await db!.rawQuery("SELECT * FROM $tblUsers WHERE $colId = '$userId'");
    return result.length > 0 ? User.fromObject(result[0]) : null;
  }

  Future<List<User>> getAll() async {
    Database? db = await this.db;
    var result = await db!
        .rawQuery("SELECT * FROM $tblUsers ORDER BY $colCreatedAt ASC");
    return result.map((row) => User.fromObject(row)).toList();
  }

  Future<int> updateUser(User user) async {
    Database? db = await this.db;
    var result = await db!.rawUpdate("UPDATE $tblUsers " +
        "SET $colName = '${user.name}'" +
        ", $colProfilePictureKey = '${user.profilePictureKey}' " +
        "WHERE $colId = '${user.userId}'");
    return result;
  }

  Future<int> deleteUser(String? userId) async {
    int result;
    Database? db = await this.db;
    result =
        await db!.rawDelete('DELETE FROM $tblUsers where $colId = $userId');
    return result;
  }
}
