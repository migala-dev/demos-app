import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/models/manifesto/manifesto_option.model.dart';
import 'package:demos_app/core/repositories/app_repository.dart';

class ManifestoOptionRepository extends AppRepository implements Table {
  final String tbManifestoOptions = 'manifesto_options';
  final String colId = 'manifestoOptionId';
  final String colTitle = 'title';
  final String colManifestoId = 'manifestoId';
  final String colDeleted = 'deleted';
  final String colCreatedBy = 'createdBy';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedBy = 'updatedBy';
  final String colUpdatedAt = 'updatedAt';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tbManifestoOptions('
      '$colId TEXT PRIMARY KEY, '
      '$colTitle TEXT,'
      '$colManifestoId TEXT,'
      '$colDeleted INTEGER,'
      '$colCreatedBy TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedBy TEXT,'
      '$colUpdatedAt TEXT)';

  Future<String> insert(ManifestoOption manifestoOption) async {
    Database? db = await this.db;
    ManifestoOption? manifestoOptionSaved =
        await findById(manifestoOption.manifestoId);
    if (manifestoOptionSaved == null) {
      await db!.insert(tbManifestoOptions, manifestoOption.toMap());
      return manifestoOption.manifestoOptionId;
    }
    return manifestoOptionSaved.manifestoOptionId;
  }

  Future<ManifestoOption?> findById(String manifestoOptionId) async {
    Database? db = await this.db;
    final result = await db!.rawQuery(
        "SELECT * FROM $tbManifestoOptions WHERE $colId = '$manifestoOptionId'");
    return result.isNotEmpty ? ManifestoOption.fromObject(result[0]) : null;
  }
}
