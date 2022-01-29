import 'package:demos_app/utils/secure_sql_string.util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/repositories/app_repository.dart';
import 'package:demos_app/core/models/manifesto/manifesto.model.dart';

class ManifestoRepository extends AppRepository implements Table {
  static final ManifestoRepository _manifestoRepository =
      ManifestoRepository._internal();

  factory ManifestoRepository() => _manifestoRepository;
  ManifestoRepository._internal();

  final String tblManifesto = 'manifesto';
  final String colId = 'manifestoId';
  final String colTitle = 'title';
  final String colContent = 'content';
  final String colOptionType = 'optionType';
  final String colSpaceId = 'spaceId';
  final String colCreatedBy = 'createdBy';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedBy = 'updatedBy';
  final String colUpdatedAt = 'updatedAt';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblManifesto('
      '$colId TEXT PRIMARY KEY, '
      '$colTitle TEXT, '
      '$colContent TEXT,'
      '$colOptionType INTEGER,'
      '$colSpaceId TEXT,'
      '$colCreatedBy TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedBy TEXT,'
      '$colUpdatedAt TEXT)';

  Future<String> insertOrUpdate(Manifesto manifesto) async {
    Database? db = await this.db;
    Manifesto? manifestoSaved = await findById(manifesto.manifestoId);
    if (manifestoSaved == null) {
      await db!.insert(tblManifesto, manifesto.toMap());
      return manifesto.manifestoId;
    }
    return update(manifesto).toString();
  }

  Future<String> insert(Manifesto manifesto) async {
    Database? db = await this.db;
    Manifesto? manifestoSaved = await findById(manifesto.manifestoId);
    if (manifestoSaved == null) {
      await db!.insert(tblManifesto, manifesto.toMap());
      return manifesto.manifestoId;
    }
    return manifestoSaved.manifestoId;
  }

  Future<Manifesto?> findById(String manifestoId) async {
    Database? db = await this.db;
    final result = await db!
        .rawQuery("SELECT * FROM $tblManifesto WHERE $colId = '$manifestoId'");
    return result.isNotEmpty ? Manifesto.fromObject(result[0]) : null;
  }

  Future<int> update(Manifesto manifesto) async {
    Database? db = await this.db;
    final result = await db!.rawUpdate('UPDATE $tblManifesto '
        "SET $colTitle = '${secureSQLString(manifesto.title)}'"
        ", $colContent = '${secureSQLString(manifesto.content)}'"
        ', $colOptionType = ${manifesto.optionType.index}'
        ", $colUpdatedBy = '${manifesto.updatedBy}' "
        ", $colUpdatedAt = '${manifesto.updatedAt}' "
        "WHERE $colId = '${manifesto.manifestoId}'");
    return result;
  }
}
