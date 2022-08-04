import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_part.model.dart';
import 'package:validators/validators.dart';

class CommentMentionPreprocessorService {
  static const String mentionPattern = '@member@';

  static List<CommentPart> split(String comment) {
    final commentSplited = comment.split(mentionPattern);

    return commentSplited
        .map((part) => CommentPart(isUUID(part), part))
        .toList();
  }

  static String addMentionToStart(String uuid, String str) {
    if (!isUUID(uuid)) {
      throw Exception('uuid is not valid');
    }

    return '$mentionPattern$uuid$mentionPattern $str';
  }
}
