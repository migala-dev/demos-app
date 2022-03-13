import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/repositories/app_repository.dart';

class ManifestoCommentRepository extends AppRepository implements Table {
  final String tblManifestoComment = 'manifesto_comment';
  final String colId = 'manifestoCommentId';
  final String colContent = 'content';
  final String colManifestoCommentParentId = 'manifestoCommentParentId';
  final String colDeleted = 'deleted';
  final String colCreatedAt = 'createdAt';
  final String colCreatedByMember = 'createdByMember';
  final String colUpdatedBy = 'updatedBy';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblManifestoComment('
      '$colId TEXT PRIMARY KEY, '
      '$colContent TEXT,'
      '$colManifestoCommentParentId TEXT,'
      '$colDeleted INTEGER,'
      '$colCreatedAt TEXT,'
      '$colCreatedByMember TEXT,'
      '$colUpdatedBy TEXT)';
}
