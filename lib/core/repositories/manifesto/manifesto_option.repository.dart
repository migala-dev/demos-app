import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/models/manifesto/manifesto_option.model.dart';
import 'package:demos_app/core/repositories/app_repository.dart';

class ManifestoOptionRepository extends AppRepository implements Table {
  final String tblManifestoOptions = 'manifesto_options';
  final String colId = 'manifestoOptionId';
  final String colTitle = 'title';
  final String colManifestoId = 'manifestoId';
  final String colDeleted = 'deleted';
  final String colCreatedBy = 'createdBy';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedBy = 'updatedBy';
  final String colUpdatedAt = 'updatedAt';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblManifestoOptions('
      '$colId TEXT PRIMARY KEY, '
      '$colTitle TEXT,'
      '$colManifestoId TEXT,'
      '$colDeleted INTEGER,'
      '$colCreatedBy TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedBy TEXT,'
      '$colUpdatedAt TEXT)';


  Future<String> insertOrUpdate(ManifestoOption manifestoOption) async {
    Database? db = await this.db;
    ManifestoOption? manifestoOptionSaved = await findById(manifestoOption.manifestoOptionId);
    if (manifestoOptionSaved == null) {
      await db!.insert(tblManifestoOptions, manifestoOption.toMap());
      return manifestoOption.manifestoOptionId;
    }
    return update(manifestoOption).toString();
  }

  Future<String> insert(ManifestoOption manifestoOption) async {
    Database? db = await this.db;
    ManifestoOption? manifestoOptionSaved = await findById(manifestoOption.manifestoOptionId);
    if (manifestoOptionSaved == null) {
      await db!.insert(tblManifestoOptions, manifestoOption.toMap());
      return manifestoOption.manifestoOptionId;
    }
    return manifestoOptionSaved.manifestoOptionId;
  }

  Future<ManifestoOption?> findById(String manifestoOptionId) async {
    Database? db = await this.db;
    final result = await db!.rawQuery(
        "SELECT * FROM $tblManifestoOptions WHERE $colId = '$manifestoOptionId'");
    return result.isNotEmpty ? ManifestoOption.fromObject(result[0]) : null;
  }

  Future<int> update(ManifestoOption manifestoOption) async {
    Database? db = await this.db;
    final result = await db!.rawUpdate('UPDATE $tblManifestoOptions '
        "SET $colTitle = '${manifestoOption.title}'"
        ', $colDeleted = ${manifestoOption.deleted ? 1 : 0} '
        ", $colUpdatedBy = '${manifestoOption.updatedBy}' "
        ", $colUpdatedAt = '${manifestoOption.updatedAt}' "
        "WHERE $colId = '${manifestoOption.manifestoOptionId}'");
    return result;
  }
}
