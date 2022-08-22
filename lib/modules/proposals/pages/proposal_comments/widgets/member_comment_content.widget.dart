import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_part.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/models/comment_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/services/comment_mention_preprocessor.service.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/mention_tile.widget.dart';
import 'package:demos_app/modules/spaces/models/member_view.model.dart';
import 'package:demos_app/modules/spaces/pages/new_space/screens/members/services/member_view.service.dart';
import 'package:flutter/material.dart';

class MemeberCommentContent extends StatelessWidget {
  final CommentView comment;
  final bool commentIsDeleted;
  const MemeberCommentContent(
      {Key? key, required this.comment, required this.commentIsDeleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commentParts =
        CommentMentionPreprocessorService.splitCommentByMentions(
            comment.content);
    final hasMention = commentParts.any((part) => part.isMention);

    if (hasMention) {
      return buildContentWithMention(commentParts);
    }

    return Text(commentIsDeleted ? '[Comentario Eliminado]' : comment.content,
        style: TextStyle(color: Colors.grey.shade700));
  }

  Widget buildContentWithMention(List<CommentPart> parts) {
    return Wrap(
      children: parts
          .map(
            (part) => part.isMention ? buildMetion(part) : Text(part.content),
          )
          .toList(),
    );
  }

  Widget buildMetion(CommentPart part) {
    return FutureBuilder(
      future: MemberViewService().getMemberViewByMemberId(part.content),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<MemberView?> snapshot) {
        if (snapshot.hasData) {
          final member = snapshot.data;

          return MentionTile(member: member!);
        }

        return const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
