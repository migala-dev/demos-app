import 'package:demos_app/core/interfaces/table.interface.dart';
import 'package:demos_app/core/repositories/app_repository.dart';

class ManifestoCommentVoteRepository extends AppRepository implements Table {
  final String tblManifestoCommentVote = 'manifesto_comment_vote';
  final String colId = 'manifestoCommentVoteId';
  final String colUserId = 'userId';
  final String colUpvote = 'upvote';
  final String colCreatedAt = 'createdAt';
  final String colUpdatedAt = 'updatedAt';

  @override
  String getCreateTableQuery() => 'CREATE TABLE $tblManifestoCommentVote('
      '$colId TEXT PRIMARY KEY, '
      '$colUserId TEXT, '
      '$colUpvote BOOLEAN,'
      '$colCreatedAt TEXT,'
      '$colUpdatedAt TEXT)';
}
