import 'package:sqflite/sqflite.dart';
import 'package:demos_app/core/models/manifesto/manifesto.model.dart';
import 'package:demos_app/core/repositories/base.repository.dart';
import 'package:demos_app/core/enums/proposal/proposal_status.enum.dart';

class ManifestoRepository extends BaseRepository {
  static final ManifestoRepository _manifestoRepository =
      ManifestoRepository._internal();

  factory ManifestoRepository() => _manifestoRepository;
  ManifestoRepository._internal();

  @override
  String get fileName => 'manifesto';
  final String tbManifesto = 'manifesto';
  final String colId = 'manifestoId';
  final String colTitle = 'title';
  final String colContent = 'content';
  final String colOptionType = 'optionType';
  final String colSpaceId = 'spaceId';
  final String colCreatedBy = 'createdBy';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedBy = 'colUpdatedBy';
  final String colUpdatedAt = 'colUpdatedAt';

  @override
  void createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tbManifesto('
        '$colId TEXT PRIMARY KEY, '
        '$colTitle TEXT, '
        '$colContent TEXT,'
        '$colOptionType INTEGER,'
        '$colSpaceId TEXT,'
        '$colCreatedBy TEXT,'
        '$colCreatedAt TEXT,'
        '$colUpdatedBy TEXT,'
        '$colUpdatedAt TEXT)');
  }

  Future<List<Manifesto>> findBySpaceId(String spaceId) async {
    Database? db = await this.db;

    final result = await db!
        .rawQuery("SELECT * FROM $tbManifesto WHERE  $colSpaceId = '$spaceId'");

    return result.map((row) => Manifesto.fromObject(row)).toList();
  }

  Future<Manifesto?> findOneBySpaceId(String spaceId) async {
    Database? db = await this.db;

    final result = await db!.rawQuery(
        "SELECT * FROM $tbManifesto WHERE  $colSpaceId = '$spaceId' LIMIT 1");

    return result.isNotEmpty ? Manifesto.fromObject(result.first) : null;
  }

  Future<List<Manifesto>> findBySpaceIdAndProposalStatus(
      String spaceId, ProposalStatus status) async {
    return [];
  }
}
