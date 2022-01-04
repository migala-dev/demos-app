import 'package:demos_app/core/models/manifesto/manifesto.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/repositories/base.repository.dart';

class ManifestoRepository extends BaseRepository {
  @override
  String get fileName => 'manifesto';
  final String tbManifesto = 'manifesto';
  final String colId = 'manifestoId';
  final String colTitle = 'title';
  final String colContent = 'content';
  final String colCreatedBy = 'createdBy';
  final String colOptionType = 'optionType';
  final String colSpaceId = 'spaceId';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbManifesto('
        '$colId TEXT PRIMARY KEY, '
        '$colSpaceId TEXT, '
        '$colTitle TEXT,'
        '$colContent TEXT,'
        '$colCreatedBy TEXT,'
        '$colOptionType TEXT,'
        '$colSpaceId TEXT,');
  }

  Future<String> insert(Manifesto manifesto) async {
    Database? db = await this.db;

    Manifesto? manifestoSaved = await findByManifestoId(manifesto.manifestoId);
    if (manifestoSaved == null) {
      await db!.insert(tbManifesto, manifesto.toMap());

      return manifesto.manifestoId;
    }

    return manifestoSaved.manifestoId;
  }

  Future<Manifesto?> findByManifestoId(String manifestoId) async {
    Database? db = await this.db;

    final result = await db!
        .rawQuery("SELECT * FROM $tbManifesto WHERE  $colId = '$manifestoId'");

    return result.isNotEmpty ? Manifesto.fromObject(result[0]) : null;
  }

  Future<List<Manifesto>> findBySpaceId(String spaceId) async {
    Database? db = await this.db;

    final result = await db!
        .rawQuery("SELECT * FROM $tbManifesto WHERE  $colSpaceId = '$spaceId'");

    return result.map((row) => Manifesto.fromObject(row)).toList();
  }
}
