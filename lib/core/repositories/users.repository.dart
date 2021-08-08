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
  String colProfilePictureUrl = "profilePictureUrl";
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
        "$colId INTEGER PRIMARY KEY, " +
        "$colName TEXT, " +
        "$colPhoneNumber TEXT UNIQUE," +
        "$colProfilePictureUrl TEXT," +
        "$colCreatedAt TEXT," +
        "$colUpdatedAt TEXT)");
  }

  Future<int> insert(User user) async {
    Database? db = await this.db;
    User? userSaved = await getUserByPhoneNumber(user.phoneNumber);
    if (userSaved == null) {
      int result = await db!.insert(tblUsers, user.toMap());
      return result;
    }
    return userSaved.userId ?? 0;
  }

  Future<User?> getUserByPhoneNumber(String phoneNumber) async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblUsers WHERE $colPhoneNumber = $phoneNumber");
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
    var result = await db!.update(tblUsers, user.toMap(),
        where: "$colId = ?", whereArgs: [user.userId]);
    return result;
  }

  Future<int> deleteUser(int? userId) async {
    int result;
    Database? db = await this.db;
    result =
        await db!.rawDelete('DELETE FROM $tblUsers where $colId = $userId');
    return result;
  }
}
