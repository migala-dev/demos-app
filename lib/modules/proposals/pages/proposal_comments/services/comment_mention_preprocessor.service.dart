import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_part.model.dart';
import 'package:validators/validators.dart';

class CommentMentionPreprocessorService {
  static const String mentionPattern = '@member@';

  static List<CommentPart> splitCommentByMentions(String comment) {
    final commentSplited = comment.split(mentionPattern);

    return commentSplited
        .map((part) => CommentPart(isUUID(part), part))
        .toList();
  }

  static String appendMentionAtBeginigOfTheMessage(
      String memberId, String str) {
    if (!isUUID(memberId)) {
      throw Exception('uuid is not valid');
    }

    return '$mentionPattern$memberId$mentionPattern $str';
  }

  static String deleteMentions(String comment) {
    final commentParts =
        splitCommentByMentions(comment).where((part) => !part.isMention);

    return commentParts.map((part) => part.content).join();
  }
}
