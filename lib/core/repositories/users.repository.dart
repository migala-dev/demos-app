import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:demos_app/core/models/user.model.dart';

class UsersRepository extends AppRepository implements Table {
  static final UsersRepository _usersRepository = UsersRepository._internal();
  final String tblUsers = 'user';
  final String colId = 'userId';
  final String colName = 'name';
  final String colPhoneNumber = 'phoneNumber';
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
      '$colPhoneNumber TEXT UNIQUE,'
      '$colProfilePictureKey TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedAt TEXT)';

  Future<String> insertOrUpdate(User user) async {
    Database? db = await this.db;
    User? userSaved = await findById(user.userId!);
    if (userSaved == null) {
      await db!.insert(tblUsers, user.toMap());
      return user.userId!;
    }
    return updateUser(user).toString();
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
    final result = await db!.rawQuery(
        "SELECT * FROM $tblUsers WHERE $colPhoneNumber LIKE '%$phoneNumber'");
    return result.isNotEmpty ? User.fromObject(result[0]) : null;
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
            "SET $colName = '${user.name}'" +
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
