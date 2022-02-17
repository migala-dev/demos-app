import 'package:demos_app/modules/proposals/pages/proposal_comments/models/member_comment_view.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_comments/widgets/comment_votes_count.widget.dart';
import 'package:demos_app/widgets/profile/profile_picture.widget.dart';
import 'package:flutter/material.dart';

class MemberComment extends StatelessWidget {
  final MemberCommentView comment;
  const MemberComment({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        flex: 1,
        child: Column(
          children: [
            ProfilePicture(
              imageKey: comment.profilePictureKey,
              width: 55,
              percentage: 0.9,
            ),
            CommentVotesCount(
                votesInFavor: comment.upVotesCount,
                votesInOpposing: comment.downVotesCount)
          ],
        ),
      ),
      Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${comment.memberName} ',
                    overflow: TextOverflow.clip,
                  ),
                  Text(comment.createdAtFormatted,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(color: Colors.grey, fontSize: 12))
                ],
              ),
              Text(comment.content,
                  style: TextStyle(color: Colors.grey.shade700))
            ],
          )),
      Expanded(
          flex: 1,
          child:
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))),
    ]);
  }
}
