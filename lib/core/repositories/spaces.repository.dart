import 'package:demos_app/utils/secure_sql_string.util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:demos_app/core/models/space.model.dart';

class SpacesRepository extends AppRepository implements Table {
  static final SpacesRepository _spacesRepository =
      SpacesRepository._internal();
  final String tblSpaces = 'space';
  final String colId = 'spaceId';
  final String colName = 'name';
  final String colDescription = 'description';
  final String colPictureKey = 'pictureKey';
  final String colOwnerId = 'ownerId';
  final String colApprovalPercentage = 'approvalPercentage';
  final String colParticipationPercentage = 'participationPercentage';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedAt = 'updatedAt';

  SpacesRepository._internal();

  factory SpacesRepository() {
    return _spacesRepository;
  }

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblSpaces('
      '$colId TEXT PRIMARY KEY, '
      '$colName TEXT, '
      '$colDescription TEXT,'
      '$colPictureKey TEXT,'
      '$colOwnerId TEXT,'
      '$colApprovalPercentage INTEGER,'
      '$colParticipationPercentage INTEGER,'
      '$colCreatedAt TEXT,'
      '$colUpdatedAt TEXT)';

  Future<String> insert(Space space) async {
    Database? db = await this.db;
    Space? spaceSaved = await findById(space.spaceId!);
    if (spaceSaved == null) {
      await db!.insert(tblSpaces, space.toMap());
      return space.spaceId!;
    }
    return updateSpace(spaceSaved).toString();
  }

  Future<Space?> findById(String spaceId) async {
    Database? db = await this.db;
    final result = await db!
        .rawQuery("SELECT * FROM $tblSpaces WHERE $colId = '$spaceId'");
    return result.isNotEmpty ? Space.fromObject(result[0]) : null;
  }

  Future<List<Space>> getAll() async {
    Database? db = await this.db;
    final result = await db!
        .rawQuery('SELECT * FROM $tblSpaces ORDER BY $colCreatedAt ASC');
    return result.map((row) => Space.fromObject(row)).toList();
  }

  Future<int> updateSpace(Space space) async {
    Database? db = await this.db;
    var result = await db!.rawUpdate('UPDATE $tblSpaces '
            "SET $colName = '${secureSQLString(space.name)}'" +
        (space.pictureKey != null
            ? ", $colPictureKey = '${space.pictureKey}' "
            : '') +
        (space.description != null
            ? ", $colDescription = '${secureSQLString(space.description)}' "
            : '') +
        ", $colApprovalPercentage = '${space.approvalPercentage}' " +
        ", $colParticipationPercentage = '${space.participationPercentage}' " +
        ", $colUpdatedAt = '${space.updatedAt}' " +
        "WHERE $colId = '${space.spaceId}'");
    return result;
  }

  Future<int> deleteSpace(String? spaceId) async {
    Database? db = await this.db;
    final int result =
        await db!.rawDelete('DELETE FROM $tblSpaces where $colId = $spaceId');
    return result;
  }
}
