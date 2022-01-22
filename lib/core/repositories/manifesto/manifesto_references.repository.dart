import 'package:demos_app/core/repositories/demos_table.repository.dart';

class ManifestoReferencesRepository extends DemosTable {
  final String tbManifestoReferences = 'manifesto_references';
  final String colId = 'referenceId';
  final String colParentId = 'parentId';
  final String colManifestoId = 'manifestoId';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tbManifestoReferences('
      '$colId TEXT PRIMARY KEY, '
      '$colParentId TEXT,'
      '$colManifestoId TEXT)';
}
