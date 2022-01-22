import 'package:demos_app/core/repositories/app_repository.dart';

class ManifestoRepository extends AppRepository {
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
  String getCreateTableQuery() => 'CREATE TABLE $tbManifesto('
      '$colId TEXT PRIMARY KEY, '
      '$colTitle TEXT, '
      '$colContent TEXT,'
      '$colOptionType INTEGER,'
      '$colSpaceId TEXT,'
      '$colCreatedBy TEXT,'
      '$colCreatedAt TEXT,'
      '$colUpdatedBy TEXT,'
      '$colUpdatedAt TEXT)';
}
