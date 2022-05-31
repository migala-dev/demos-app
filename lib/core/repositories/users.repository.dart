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
import 'package:demos_app/core/models/user.model.dart';

class UsersRepository extends AppRepository implements Table {
  static final UsersRepository _usersRepository = UsersRepository._internal();
  final String tblUsers = 'user';
  final String colId = 'userId';
  final String colName = 'name';
  final String colProfilePictureKey = 'profilePictureKey';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedAt = 'updatedAt';

  UsersRepository._internal();

  factory UsersRepository() {
    return _usersRepository;
  }

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblUsers('
      '$colId TEXT PRIMARY KEY, '
      '$colName TEXT, '
      '$colProfilePictureKey TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedAt TEXT)';

  Future<String> insertOrUpdate(User user) async {
    Database? db = await this.db;
    User? userSaved = await findById(user.userId);
    if (userSaved == null) {
      await db!.insert(tblUsers, user.toMap());
      return user.userId;
    }
    return updateUser(user).toString();
  }

  Future<String> insert(User user) async {
    Database? db = await this.db;
    User? userSaved = await findById(user.userId);
    if (userSaved == null) {
      await db!.insert(tblUsers, user.toMap());
      return user.userId;
    }
    return userSaved.userId;
  }

  Future<User?> findById(String userId) async {
    Database? db = await this.db;
    final result =
        await db!.rawQuery("SELECT * FROM $tblUsers WHERE $colId = '$userId'");
    return result.isNotEmpty ? User.fromObject(result[0]) : null;
  }

  Future<List<User>> getAll() async {
    Database? db = await this.db;
    final result = await db!
        .rawQuery('SELECT * FROM $tblUsers ORDER BY $colCreatedAt ASC');
    return result.map((row) => User.fromObject(row)).toList();
  }

  Future<int> updateUser(User user) async {
    Database? db = await this.db;
    final result = await db!.rawUpdate('UPDATE $tblUsers '
            "SET $colName = '${secureSQLString(user.name)}'" +
        (user.profilePictureKey != null
            ? ", $colProfilePictureKey = '${user.profilePictureKey}'"
            : '') +
        " WHERE $colId = '${user.userId}'");
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
